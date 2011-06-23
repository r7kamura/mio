class UserController < ApplicationController

  def index
    @users = User.desc.page(params[:page])
  end

  def timeline
    if params[:id]
      @user = User.find(params[:id])
    elsif params[:name]
      @user = User.find_by_screen_name(params[:name])
    else
      redirect_to :root
      return
    end
    @tweets = @user.tweets.no_room.timeline.page(params[:page])
  end

  def setting
    @user = current_user
  end

  def update
    u = current_user
    u.profile_image_url = params[:profile_image_url] if params[:profile_image_url]
    u.screen_name       = params[:screen_name]
    u.save
    redirect_to :tweet_home
  end

  # 補完用ユーザ名一覧
  def names
    render :text => (params[:q][0] == "@") ?
      User.where("screen_name like ?", "#{params[:q][1..-1]}%")\
        .order("screen_name")\
        .map{|u| "@#{u.screen_name}" }.join("\n") : ""
  end
end
