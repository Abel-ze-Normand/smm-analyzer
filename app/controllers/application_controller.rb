class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from VK::APIError, with: :handle_vk_api_error

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

  def logout_user
    session[:user_id] = nil
    session[:access_token] = nil
  end

  def handle_vk_api_error(e)
    case e.code
    when 5 # description: User authorization failed: access_token was given to another ip address.
      logout_user
      redirect_to login_path
    end
  end
end
