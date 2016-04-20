require 'fileutils'

class Video
  include Mongoid::Document
  include Mongoid::Timestamps

  field :filename, type: String # Filename: video.mp4
  field :origin_file_path, type: String # Path to origin video file (user)
  field :crop_path, type: String
  field :start_time, type: Integer
  field :end_time, type: Integer
  field :duration, type: Integer
  field :status, type: String # done, failed, scheduled, processing

  before_create :set_duration, :save_file
  after_create :ffmpeg_transcode

  belongs_to :user

  validate :ffmpeg_validation

  # @param value [UploadedFile]
  def video=(value)
    self.filename = value.original_filename
    # TempFile path
    @tmp_file_path = value.tempfile.path

    self.origin_file_path = file_storage_path('origin')
    self.crop_path = file_storage_path
  end

  def transcode_complite
    self.status = 'done'
    self.save
  end

  def video_path
    self.crop_path.sub(Rails.root.join('public').to_s, '')
  end

  def transcode
    ffmpeg_transcode
  end

  private

    def ffmpeg_validation
      tmp_file_path = @tmp_file_path
      tmp_file_path ||= self.origin_file_path

      movie = FFMPEG::Movie.new(tmp_file_path)
      # (would be false if ffmpeg fails to read the movie)
      unless movie.valid?
        Error.create(msg: 'Not supported video format')
        errors.add(:base, 'Not supported video format')
      end
    end

    def save_file
      # Create directory
      dirname = File.dirname(self.origin_file_path)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end

      # Copy TempFile from OS temp directory
      FileUtils.cp(@tmp_file_path, self.origin_file_path)
    end

    # Crop video file
    def ffmpeg_transcode
      movie = FFMPEG::Movie.new(self.origin_file_path)
      # Detect supported format
      if movie.valid?
        self.status = 'scheduled'
        self.save

        # TODO: run as rails job (scheduler)
        job = Thread.new do
          command = "-ss #{self.start_time} -t #{self.duration} -c copy"
          self.status = 'processing'
          self.save
          begin
            movie.transcode(self.crop_path, command){|progress| self.transcode_complite if progress >= 1}
          rescue
            self.status = 'failed'
            self.save
          end
        end
        job.join if Rails.env == 'test' # HOTFIX for testing
        # rails job

      else
        self.status = 'failed'
        self.save
      end
    end

    def set_duration
      self.duration = self.end_time - self.start_time
    end

    def file_storage_path(ftype='crop')
      fname = "#{ftype}_#{self.filename}"
      Rails.root.join('public', Rails.env, 'video', self.id, fname)
    end

end
