class RoomController < ApplicationController
  before_filter :authenticate_user!

  def index
    @rooms = Room.order("created_at DESC").page(params[:page])
    @users = User.from_rooms(@rooms)
  end

  def show
    @room = Room.where(:name => params[:name]).first
    unless @room
      redirect_to :root
      return
    end

    @room_id = @room.id
    @tweets = @room.tweets.timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
  end

  def delete
    @room = Room.find(params[:id])
    if @room && @room.user_id == current_user.id
      @room.update_attributes(:deleted_at => Time.now)
    end
    redirect_to room_index_url
  end

end
