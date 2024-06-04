class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  #before_action :authenticate_user!
  before_action :authenticate_user!, except: [:create, :list] #pode quebrar
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def current
    render json: { email: current_user.email }
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
    params.require(:user).permit(:email, :nome, :telefone, :cep, :rua, :numero, :complemento, :password)
  end
end
