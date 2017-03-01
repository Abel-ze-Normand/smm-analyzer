class AuthControllerController < ApplicationController
  def login
    redirect_to dashboard_path if user_logged?
    @auth_path = Vk::PreAuthenticatorService.new.call
  end

  def auth
    user, access_token = Vk::AuthenticatorService.new(params).call
    login_user(user)
    memorize_access_token(access_token)
    redirect_to dashboard_path
  end
end
