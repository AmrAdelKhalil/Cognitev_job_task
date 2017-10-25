class StatusesController < ApplicationController

  before_action :permit_params, only: [:create]

  def create

    user = User.where(phone_number: params[:phone_number], auth_token: params[:auth_token]).first

    render json:{"error" => "unauthorized request"}, status: :unauthorized if user.nil?

    status = user.statuses.build
    status.description = params[:status]

    if status.save
      user_object = UserSerializer.new(user)
      user_object = JSON.parse(user_object.to_json)
      user_object["statuses"] = user.statuses.map{|status| StatusSerializer.new(status) }.to_a
      render json: user_object, status: :ok
    else
      render json: { "errors" => status.errors }, status: :bad_request
    end
  end

  private
    def permit_params
      params.permit(:phone_number, :auth_token, :status)
    end
end
