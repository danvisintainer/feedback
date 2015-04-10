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

    twitter_user = client.user(include_entities: true)

    binding.pry
    puts "Trying to create new AR object..."
    @user = User.find_or_create_by(twitter_username: twitter_user.screen_name)
    puts "Setting name..."
    @user.name ||= twitter_user.name
    puts "Setting avatar..."
    @user.avatar_url = twitter_user.profile_image_uri.to_s
    # Password digest can't be blank so Twitter users still need content stored in the DB.
    puts "Setting password digest..."
    @user.password_digest ||= "no_password"
    puts "Saving..."
    @user.save

    session[:user_id] = @user.id

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
