class TweetController < ApplicationController
  def home
    @tweets = Tweet.friend_timeline(session[:self]).regular_limit
  end

  def user
    @tweets = Tweet.user_timeline.regular_limit
  end

  def show
    @tweet = Tweet.find(params[:id])
  end
end
