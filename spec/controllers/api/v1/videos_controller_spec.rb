require 'rails_helper'

RSpec.describe Api::V1::VideosController, type: :controller do

  describe 'POST #crop' do

    before do
      User.destroy_all
      Video.destroy_all
      Error.destroy_all
    end

    after do
      User.destroy_all
      Video.destroy_all
      Error.destroy_all
    end

    it 'Wrong number of arguments' do
      post :crop, user_uid: 0
      expect(response).to have_http_status(400)
      expect(Error.count).to be 1
    end

    it 'Responds successfully with an HTTP 200 status code' do
      video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
      file = fixture_file_upload(video_file_path)

      post :crop, user_uid: '', video: file, start_time: 0, end_time: 120

      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(User.count).to be 1

      user = User.first
      expect(user.videos.count).to be 1
      video = user.videos.first

      expect(video.status).to eq 'done'
    end

    it 'Wrong video format' do
      video_file_path = Rails.root.join('spec', 'fixtures', 'doc', 'test.txt')
      file = fixture_file_upload(video_file_path)

      post :crop, user_uid: '', video: file, start_time: 0, end_time: 120

      expect(response).to have_http_status(400)
      resp = JSON.parse(response.body)
      expect(resp.key?('errors')).to be_truthy
      expect(Error.count).to be 1
    end

    it 'User upload 2 files' do
      video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
      file = fixture_file_upload(video_file_path)

      user = User.create

      post :crop, user_uid: user.uid, video: file, start_time: 0, end_time: 120

      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(User.count).to be 1

      expect(user.videos.count).to be 1
      video = user.videos.first

      expect(video.status).to eq 'done'

      # Second file
      post :crop, user_uid: user.uid, video: file, start_time: 0, end_time: 120

      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(User.count).to be 1

      expect(user.videos.count).to be 2
      video = user.videos.last

      expect(video.status).to eq 'done'
    end


    it 'Videos list' do

      user = User.create

      video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
      file = fixture_file_upload(video_file_path)

      user.videos.create(video: file, start_time: 0, end_time: 120)
      user.videos.create(video: file, start_time: 20, end_time: 140)

      get :index, user_uid: user.uid

      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(Video.count).to be 2

      resp = JSON.parse(response.body)

      expect(resp.length).to be 2
      expect(resp.first['duration']).to be 120
    end

    it 'Restsrt transcoding video' do

      user = User.create

      video_file_path = Rails.root.join('spec', 'fixtures', 'video', 'test.mp4')
      file = fixture_file_upload(video_file_path)

      video = user.videos.create(video: file, start_time: 0, end_time: 120)

      video.status = 'failed'
      video.save

      expect(Video.count).to be 1

      post :restart, user_uid: user.uid, video_id: video.id

      expect(response).to be_success
      expect(response).to have_http_status(200)

      expect(Video.count).to be 1
      expect(Video.first.status).to eq 'done'
    end

  end
end
