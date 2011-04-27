class TweetController < ApplicationController
  def home
    @tweets = Tweet.timeline
  end

  def user
    user = User.where(:screen_name => params[:user]).first
    # redirect_to 404 unless user
    @tweets = Tweet.user(user).timeline
  end

  def show
    @tweet = Tweet.find(params[:id])
    #redirect_to 404 unless @tweet
  end
end
