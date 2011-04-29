class RoomController < ApplicationController
  def index
    @rooms = Room.order("created_at DESC")
  end

  def show
    @room = Room.where(:name => params[:name]).first
    unless @room
      redirect_to :root
      return
    end

    @room_id = @room.id
    @tweets = @room.tweets.timeline
  end

end