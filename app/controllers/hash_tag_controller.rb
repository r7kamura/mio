class HashTagController < ApplicationController
  before_filter :authenticate_user!

  def show
    @hash_tag = HashTag.where(:name => params[:name]).first
    unless @hash_tag
      redirect_to :root
      return
    end

    @tweets = @hash_tag.tweets.no_room.timeline.page(params[:page])
    @favorites = Favorite.from_tweets(@tweets)
    @users = User.from_tweets(@tweets)
  end

end
