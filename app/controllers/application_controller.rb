class ApplicationController < ActionController::Base 
	protect_from_forgery with: :exception 
	helper_method :current_user, :logged_in?
	
	def current_user
		@current_user ||= UserLogin.find_by(id: session[:user_id]) if session[:user_id] 
	end
			
	def logged_in?
		!!current_user 
	end
	
	def require_login
		unless logged_in? 
			flash[:error] = "You must be logged in to access this page" 
			redirect_to root_path 
		end
	end
end
