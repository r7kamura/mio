class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :adjust_iphone, :authenticate_user!

  def mobile?
    request.user_agent =~ /(Mobile\/.+Safari)|(Android)/
  end
  helper_method :mobile?

  def adjust_iphone
    request.format = :iphone if mobile?
  end

end
