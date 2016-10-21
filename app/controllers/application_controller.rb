class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
		return @current_user if @current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id])	
		end
	end

	def signed_in?
		if current_user.present?
			return current_user
		end
		return nil
	end

  def require_login
  	unless signed_in?
  		redirect_to login_path, notice: "You must sign in to see this page!"
  	end
  end

  def skip_if_logged_in
  	if signed_in?
  		redirect_to user_path, notice: "You must sign in to see this page!"
  	end
  end
end
