require 'rails_helper'

RSpec.describe Api::V1::VideoController, type: :controller do

  describe 'POST #crop' do

    it 'wrong number of arguments' do
      post :crop, user_uid: 0
      expect(response).to have_http_status(400)
    end

    it 'responds successfully with an HTTP 200 status code' do

      video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
      file = fixture_file_upload(video_file_path)


      post :crop, user_uid: 0, video: file, start_time: 0, end_time: 120

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end
end
