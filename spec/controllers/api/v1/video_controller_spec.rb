require 'rails_helper'

RSpec.describe Api::V1::VideoController, type: :controller do

  describe 'POST #crop' do

    before do
      User.destroy_all
      Video.destroy_all
    end

    after do
      User.destroy_all
      Video.destroy_all
    end

    # it 'wrong number of arguments' do
    #   post :crop, user_uid: 0
    #   expect(response).to have_http_status(400)
    # end
    #
    it 'responds successfully with an HTTP 200 status code' do

      video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
      file = fixture_file_upload(video_file_path)


      post :crop, user_uid: '', video: file, start_time: 0, end_time: 120

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    # it 'df' do
    #
    #   video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
    #
    #   movie = FFMPEG::Movie.new(video_file_path)
    #
    #
    #   p movie.size
    #
    #   movie.transcode(Rails.root.join('spec', 'fixtures', 'video', 'test2.mp4'), '-ss 20 -t 30'){ |progress| puts progress if progress >= 1 }
    #
    #
    # end

  end
end
