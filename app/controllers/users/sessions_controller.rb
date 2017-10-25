class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    self.resource = warden.authenticate!(auth_options)

    sign_in(resource_name, resource)

    user_data = UserSerializer.new(self.resource)
    user_data = JSON.parse(user_data.to_json)
    user_data[:auth_token] = self.resource.auth_token

    render json: user_data, status: 200
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:phone_number])
  end
end
