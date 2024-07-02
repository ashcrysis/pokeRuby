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
    render json: { user: user }
  end

  def update
    if @user.update(user_params)
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
    params.require(:user).permit(:email, :name, :phone, :postal_code, :street, :number, :complement).tap do |user_params|
      user_params[:password] = params[:user][:password] if params[:user][:password].present?
    end
  end
end
