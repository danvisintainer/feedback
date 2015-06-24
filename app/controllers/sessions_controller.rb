class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # Authenticate user's password
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to projects_path
    #If creating the session fails, redirect to login and display a message
    else
      flash[:notice] = "Failed to log in. Please try again."
      redirect_to '/'
    end
  end

  def create_via_twitter
    session[:access_token] = request.env['omniauth.auth']['credentials']['token']
    session[:access_token_secret] = request.env['omniauth.auth']['credentials']['secret']
    twitter_user = client.user(include_entities: true)

    @user = User.find_or_create_by(twitter_username: twitter_user.screen_name)
    @user.name ||= twitter_user.name
    @user.avatar_url = twitter_user.profile_image_uri.to_s
    # Password digest can't be blank so Twitter users still need content stored in the DB.
    @user.password_digest ||= "no_password"
    @user.save

    session[:user_id] = @user.id
    redirect_to projects_path
  end

  def new_via_soundcloud
    # redirect user to authorize URL
    redirect_to SOUNDCLOUD_CLIENT.authorize_url()
  end

  def create_via_soundcloud
    # exchange authorization code for access token
    code = params[:code]
    access_token = SOUNDCLOUD_CLIENT.exchange_token(:code => code)
    @user = User.find_or_create_by(soundcloud_token: access_token[:access_token])
    # create client object with access token
    client = Soundcloud.new(:access_token => access_token[:access_token])

    # make an authenticated call
    soundcloud_user = client.get('/me')

    # Password digest can't be blank so Soundcloud users still need an empty string stored in the DB.
    @user.password_digest ||= "no_password"
    @user.name = soundcloud_user[:username]
    @user.avatar_url = soundcloud_user.avatar_url
    @user.save

    session[:user_id] = @user.id
    redirect_to projects_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
