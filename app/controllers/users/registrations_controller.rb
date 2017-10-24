class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create

    p build_resource(sign_up_params)

    resource.save

    yield resource if block_given?

    if resource.persisted?

      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        resp =  JSON.parse(resource.to_json)
        render json: resp, status: :created
      else
        expire_data_after_sign_in!

        errors = format_errors(resource)
        
        render json: {"errors": errors}, status: :created
      end
    else
      clean_up_passwords resource
      set_minimum_password_length

      errors = format_errors(resource)

      render json: {"errors": errors}, status: :unprocessable_entity
    end
  end

  def format_errors(resource)
    formated_errors = {}
    errors_keys = resource.errors.keys
    errors_keys.each do |key|
      list_of_errors = resource.errors[key]
      formated_errors[key.to_s] = list_of_errors.map { |error| {"error": error}}
    end
    formated_errors
  end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar, :country_code, :phone_number,
      :gender, :birthdate])
  end

end
