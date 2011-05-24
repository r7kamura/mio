class UserController < ApplicationController

  def index
    @users = User.order("created_at DESC").page(params[:page])
  end

  def timeline
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:name]
      @user = User.where(:screen_name => params[:name]).first
    end
    unless @user
      redirect_to :root
      return
    end
    @tweets = @user.tweets.no_room.timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
  end

  def setting
    @user = current_user
  end

  def update
    user = current_user
    user.profile_image_url = params[:profile_image_url] if params[:profile_image_url]
    user.screen_name = params[:screen_name]
    user.save
    redirect_to :tweet_home
  end

end
