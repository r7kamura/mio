class RoomController < ApplicationController
  before_filter :authenticate_user!

  def index
    @rooms = Room.order("created_at DESC").page(params[:page])
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
  end

end
