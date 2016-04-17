class Api::V1::VideoController < Api::BaseController

  # Upload and crop video file
  def crop

    validate_params :video, :user_uid, :start_time, :end_time do

      # Get or create USER
      user = if params[:user_uid].blank? # New user
               User.create
             else
               User.find_by(uid: params[:user_uid])
             end

      p user
      p Video.new(params.permit(:video, :start_time, :end_time))
      p params[:video]
      p params[:video].original_filename
      p params[:video].tempfile.path
      # user.videos

      FileUtils.cp(params[:video].tempfile.path, Rails.root.join('private', 'video', params[:video].original_filename))


      render json: {d: 0}

      # p [:video, :user_uid, :start_time, :end_time].all?{|s| params.key? s}

      # params

      # user_uid: nil, video: file, start_time: 0, end_time: 120
    end
  end

end
