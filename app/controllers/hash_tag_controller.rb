class HashTagController < ApplicationController
  def show
    @hash_tag = HashTag.where(:name => params[:name]).first
    unless @hash_tag
      redirect_to :root
      return
    end

    @tweets = @hash_tag.tweets.timeline.page(params[:page])
  end

end
