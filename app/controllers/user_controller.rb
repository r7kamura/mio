class UserController < ApplicationController
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
