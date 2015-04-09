class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # Authenticate user's password
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def create_via_twitter
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_token_secret] = request.env['omniauth.auth']['credentials']['secret']

    @twitter_user = client.user(include_entities: true)

    @user = User.find_or_create_by(twitter_username: @twitter_user.screen_name)
    @user.name = @twitter_user.name
    @user.avatar = open(@twitter_user.profile_image_uri)
    
    @user.save
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
