class TweetController < ApplicationController
  before_filter :authenticate_user!

  def home
    @tweets = Tweet.no_room.timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
  end

  def user
    user = User.where(:screen_name => params[:user]).first
    redirect_to :root unless user

    @tweets = Tweet.user(user).timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
  end

  def create
    tweet = Tweet.create(:body => params[:body], :user => current_user, :room_id => params[:room_id])

    # Room
    if params[:body] =~ /&(\w+)(?:\s+|$)/
      Room.where(:name => $~[1]).first or Room.create(:name => $~[1], :user => current_user)
    end

    # HashTag
    if params[:body] =~ /#(\w+)(?:\s+|$)/
      hash = HashTag.where(:name => $~[1]).first || HashTag.create(:name => $~[1])
      HashTagTweet.create(:hash_tag_id => hash.id, :tweet_id => tweet.id)
    end

    respond_to do |format|
      format.html   { redirect_to request.referer }
      format.iphone { redirect_to :root }
    end
  end

  def delete
    tweet = Tweet.find(params[:id])
    if tweet && tweet.user == current_user
      tweet.delete
    end
    redirect_to request.referer
  end

  def favorite
    tweet = Tweet.find(params[:id])
    tweet && Favorite.create(:tweet_id => tweet.id, :user_id => current_user.id)
    redirect_to request.referer
  end

  def unfavorite
    tweet = Tweet.find(params[:id])
    tweet && favorite = Favorite.where(:tweet_id => tweet.id, :user_id => current_user.id).first
    if favorite
      favorite.delete
    end
    redirect_to request.referer
  end

  def update_remote
    case params[:controller_name]
    when "tweet"
      @tweets = Tweet.no_room
    when "room"
      room = Room.where(:name => params[:query_name]).first or return
      @tweets = room.tweets
    when "user"
      user = User.where(:name => params[:query_name]).first or return
      @tweets = user.tweets
    end
    @tweets = @tweets.timeline.since(params[:id])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
    render :partial => "tweet/tweet_lists"
  end

  def search
    if params[:query]
      @tweets = Tweet.search(params[:query]).no_room.timeline.page(params[:page])
      @favorites = Favorite.from_tweets(@tweets)
      @users = User.from_tweets(@tweets)
    end
  end

end
