class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  include RackSessionsFix
  respond_to :json
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
  private
  def respond_with(current_user, _opts = {})
    render json: {
      status: {
        code: 200, message: 'Logged in successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }
    }, status: :ok
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
end
