class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from ActionController::ParameterMissing do |exception|
    json_response = {
      errors: {
        "#{exception.param}" => ['can\'t be blank']
      }
    }

    render json: json_response, status: :unprocessable_entity
  end
end
