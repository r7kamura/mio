class UserController < ApplicationController
  def index
    @users = User.order("created_at DESC")
  end

  def timeline
    @user = User.find(params[:id])
    unless @user
      redirect_to :root
      return
    end
    @tweets = @user.tweets.timeline
  end

  def setting
    @user = current_user
  end

  def update
    user = current_user
    user.profile_image_url = params[:profile_image_url]
    user.screen_name = params[:screen_name]
    if user.save
      flash[:message] = "successfully updated"
    else
      flash[:message] = "error"
    end

    redirect_to :user_setting
  end

end
