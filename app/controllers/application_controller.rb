class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_logged?
    !session[:user_id].nil?
  end

  def require_login
    redirect_to root_path unless user_logged?
    get_current_user
  end

  def get_current_user
    @current_user = User.find(session[:user_id])
  end

  def login_user(user)
    session[:user_id] = user.id
  end

  def memorize_access_token(token)
    session[:access_token] = token
  end
end
