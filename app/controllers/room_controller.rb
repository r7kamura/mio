class RoomController < ApplicationController
  def index
  end

  def show
    @room = Room.where(:name => params[:name]).first
    redirect_to root unless @room

    @room_id = @room.id
    @tweets = @room.tweets.timeline
  end

end
