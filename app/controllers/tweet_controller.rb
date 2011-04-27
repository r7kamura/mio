class TweetController < ApplicationController
  before_filter :authenticate_user!

  def home
    @tweets = Tweet.timeline
  end

  def user
    user = User.where(:screen_name => params[:user]).first
    @tweets = Tweet.user(user).timeline
  end

  def show
    @tweet = Tweet.find(params[:id].to_i)
  end

  def create
    tweet = Tweet.new(:body => params[:body], :user => current_user)
    tweet.save
    redirect_to :root
  end

end
