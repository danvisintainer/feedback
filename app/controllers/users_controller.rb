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
    user.avatar_url = "#{user.primary_instrument.to_s}.jpg"
    

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
   #This prevents a change in primary instrument from overwriting a stored Twitter avatar_url
    if !@user.avatar_url.start_with?("http")
      @user.avatar_url = "#{@user.primary_instrument.to_s}.jpg"
      @user.save
    end
    redirect_to user_path(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :primary_instrument, :password, :password_confirmation)
  end

end
