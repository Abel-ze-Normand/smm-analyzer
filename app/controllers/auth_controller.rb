class AuthController < ApplicationController
  # FIXME not working?
  # layout "login", only: [:login, :logout]
  layout "", only: [:auth]
  def login
    # redirect_to dashboard_path and return if user_logged?
    redirect_to Vk::PreAuthenticatorService.new.call and return
    # render layout: "login"
  end

  def auth
    render layout: "login"
  end

  def fix_auth
    user, access_token = Vk::AuthenticatorService.new(params).call
    login_user(user)
    memorize_access_token(access_token)
    redirect_to dashboard_path
  end

  def logout
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to root_path
  end

  private

  def fixed_params
    malformed_uri = request.original_url
    proper_uri = malformed_uri.gsub(/#/, '?')
    CGI::parse(URI.parse(proper_uri).query)
  end
end
