class Api::V1::ErrorsController < Api::BaseController

  def index
    render json: Error.all.to_json(only: [:msg, :created_at])
  end

end
