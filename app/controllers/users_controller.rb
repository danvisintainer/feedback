class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
  end

  def new
    @user = User.new
    @instruments = ["Guitar", "Bass", "Drums", "Keyboards"]
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

  private
  def user_params
    params.require(:user).permit(:name, :email, :primary_instrument, :password, :password_confirmation)
  end

end
