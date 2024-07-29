class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :authenticate_user!, except: [:create, :list]

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def current
    user = User.find_by(email: current_user.email)

    if user
      user_json = UserSerializer.new(user).serializable_hash.as_json
      image_url = user.image.attached? ? url_for(user.image) : nil
      render json: user_json.merge({ image: image_url })
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def update
    Rails.logger.info "Received update request with params: #{params.inspect}"

    if user_params[:image].present?
      Rails.logger.info "Received image file: #{user_params[:image].original_filename}"

      @user.image.purge if @user.image.attached?

      @user.image.attach(user_params[:image])
    end

    if @user.update(user_params.except(:image))
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def list
    @users = User.all
    render json: @users
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :name,:password, :phone, :postal_code, :street, :number, :complement, :image)
  end
end
