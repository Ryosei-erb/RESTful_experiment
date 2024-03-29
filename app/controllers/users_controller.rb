class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index,:edit,:update,:destroy]
  before_action :correct_user, only:[:edit,:update]
  before_action :admin_user, only:[:destroy]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user && @user.update_attributes(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user) # sessions_helper
  end
  
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
end


