class TweetController < ApplicationController

  def home
    @tweets = Tweet.no_room.timeline.page(params[:page])
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def user
    if user = User.find_by_screen_name(params[:user])
      @tweets = Tweet.user(user).timeline.page(params[:page])
    else
      redirect_to :root unless user
    end
  end

  def create
    tweet = Tweet.new(
      :body    => params[:body],
      :room_id => params[:room_id],
      :user    => current_user
    )
    if params[:body] =~ /&(\w+)(?:\s+|$)/
      Room.find_by_name($~[1]) or Room.create(:name => $~[1], :user => current_user)
    end

    respond_to do |format|
      format.html do
        # pusher
        if tweet.save
          @tweets = [tweet]
          Pusher["tweet"].trigger("tweet-created", {
            :body => render_to_string(:file => "tweet/_tweet_lists.html.haml", :layout => false),
          }.tap{|data| data[:room] = Room.find(params[:room_id]).name unless params[:room_id].empty? })
        end
        redirect_to request.referer
      end
      format.js do
        # pusher
        if tweet.save
          @tweets = [tweet]
          Pusher["tweet"].trigger("tweet-created", {
            :body => render_to_string(:file => "tweet/_tweet_lists.html.haml", :layout => false),
          }.tap{|data| data[:room] = Room.find(params[:room_id]).name unless params[:room_id].empty? })
        end
        render :nothing => true
      end
      format.iphone do
        tweet.save
        redirect_to params[:room_id] ? room_show_url(Room.find(params[:room_id]).name) : :root
      end
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
    render :partial => "tweet/tweet_lists"
  end

  def search
    unless params[:query].nil? || params[:query].empty?
      @tweets = Tweet.search(params[:query]).no_room.timeline.page(params[:page])
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
