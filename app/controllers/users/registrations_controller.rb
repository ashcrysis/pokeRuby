# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

before_action :configure_sign_up_params, only: [:create]

  def create
    @user = User.new(sign_up_params)

    if @user.save
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(@user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: @user.errors.full_messages.to_sentence }
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end

    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :postal_code, :street, :number, :complement])
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :name, :phone, :postal_code, :street, :number, :complement)
  end
end
