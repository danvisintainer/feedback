class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @instruments = User.instruments
  end

  def new
    @user = User.new
    @instruments = User.instruments
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(:primary_instrument => params[:user][:primary_instrument])
        binding.pry
    redirect_to user_path(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :primary_instrument, :password, :password_confirmation)
  end

end
