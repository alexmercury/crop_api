class Api::BaseController < ActionController::API

  protected

    # Validate request params
    def validate_params(*valid_params)
      if valid_params.all?{|s| params.key? s}
        yield
      else
        Error.create(msg: 'Wrong number of arguments')
        render json: {error: 'Wrong number of arguments'}, status: 400
      end
    end

end
