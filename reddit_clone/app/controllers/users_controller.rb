class UsersController < ApplicationController
  
  before_action :ensure_signed_in, only: [:index, :show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  private

  def user_params
    params(:user).permit(:username, :password)
  end

end
