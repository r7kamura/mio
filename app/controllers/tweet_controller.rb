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
    Tweet.create(:body => params[:body], :user => current_user, :room_id => params[:room_id])
    if params[:body] =~ /(?:\s+|^)&(\w.*)(?:\s+|$)/
      Room.where(:name => $~[1]).first or Room.create(:name => $~[1], :user => current_user)
    end

    redirect_to request.referer
  end

end
