class Api::V1::VideoController < Api::BaseController

  # Upload and crop video file
  def crop

    validate_params :video, :user_uid, :start_time, :end_time do

      p params

      render json: {d: 0}

      # p [:video, :user_uid, :start_time, :end_time].all?{|s| params.key? s}

      # params

      # user_uid: nil, video: file, start_time: 0, end_time: 120
    end
  end

end
