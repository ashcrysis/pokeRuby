class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.valid_password?(params[:password])
      sign_in(@user)
      session[:email] = params[:email]
      render json: { user: @user }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def fetch_current_user
    @user = User.find_by(email: session[:email])
    if @user
      render json: { user: @user }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end
end
