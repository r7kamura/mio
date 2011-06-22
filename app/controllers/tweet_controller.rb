class TweetController < ApplicationController

  def home
    @tweets    = Tweet.no_room.timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users     = User.from_tweets(@tweets)
    end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def user
    user = User.where(:screen_name => params[:user]).first
    redirect_to :root unless user

    @tweets = Tweet.user(user).timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
  end

  def create
    tweet = Tweet.new(
      :body    => params[:body],
      :user    => current_user,
      :room_id => params[:room_id]
    )
    if tweet.save
      @tweets    = [tweet]
      @users     = User.from_tweets(@tweets)
      @favorites = []
      Pusher["tweet"].trigger("tweet-created",
        render_to_string(:file => "tweet/_tweet_lists.html.haml", :layout => false))
    end

    if params[:body] =~ /&(\w+)(?:\s+|$)/
      Room.find_by_name($~[1]) or Room.create(:name => $~[1], :user => current_user)
    end

    respond_to do |format|
      format.html   { redirect_to request.referer }
      format.js     { render :nothing => true }
      format.iphone { redirect_to params[:room_id] ? room_show_url(Room.find(params[:room_id]).name) : :root }
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
    unless params[:query].nil? || params[:query].empty?
      @tweets = Tweet.search(params[:query]).no_room.timeline.page(params[:page])
      @favorites = Favorite.from_tweets(@tweets)
      @users = User.from_tweets(@tweets)
    end
  end

  def hashtag
    params[:query] = "#" + params[:name]
    search
    render :action => :search
  end

  def replies
    params[:query] = "@#{current_user.screen_name}"
    search
  end

  def new
    @room = Room.find(params[:room_id]) if params[:room_id]
  end

end
