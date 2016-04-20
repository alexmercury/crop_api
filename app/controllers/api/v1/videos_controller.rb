class Api::V1::VideosController < Api::BaseController

  # before_action :get_user

  # Upload and crop video file
  def crop
    validate_params :video, :user_uid, :start_time, :end_time do

      # Get or create USER
      user = if params[:user_uid].blank?
               # New user
               User.create
             else
               User.find_by(uid: params[:user_uid])
             end

      video = user.videos.build(params.permit(:video, :start_time, :end_time))

      if video.save
        render json: {user_uid: user.uid}
      else
        render json: {user_uid: user.uid, errors: video.errors}, status: 400
      end
    end
  end

  def restart
    validate_params :user_uid, :video_id do
      user = User.find_by(uid: params[:user_uid])
      video = user.videos.find_by(id: params[:video_id])
      video.transcode

      render json: video.to_json(only: [:duration], methods: [:video_path])
    end
  end

  def index
    validate_params :user_uid do
      user = User.find_by(uid: params[:user_uid])
      videos = user.videos

      render json: videos.to_json(only: [:duration], methods: [:video_path])
    end
  end

  def show
    video = Video.find(params[:id])
    render json: video.to_json(only: [:duration], methods: [:video_path])
  end

end
