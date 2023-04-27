class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :exception

  before_action :set_csrf_cookie

  def current_user 
    @_current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  private
  
    def set_csrf_cookie
      cookies["CSRF-TOKEN"] = form_authenticity_token
    end
end
