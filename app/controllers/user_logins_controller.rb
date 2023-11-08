class UserLoginsController < ApplicationController
	def new
		@user_login = UserLogin.new
	end

	def create 
		username = params[:user_login][:username]
		@user_login = UserLogin.find_by(username: username) 
		
		if @user_login && authenticate_user(@user_login, params[:user_login][:password])
			session[:user_id] = @user_login.id 
			if @user_login.role == 'doctor'
				redirect_to doctors_dashboard_path 
			elsif @user_login.role == 'patient'
				redirect_to patients_dashboard_path
			else 
				flash[:error] = "Invalid role" 
				render :new, status: :unprocessable_entity, content_type: "text/html"
			end 
		else 
			flash[:error] = "Invalid username or password" 
			render :new, status: :unprocessable_entity, content_type: "text/html"
		end
	end
	
	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
		
	private

	def authenticate_user(user, password) 
		user.authenticate(password) 
	end

	# def authenticate_user 
	# 	doctor = Doctor.find_by(username: @user_login.username) 
	# 	patient = Patient.find_by(username: @user_login.username) 
		
	# 	if doctor 
	# 		@user_login.role = "doctor"
	# 		return doctor.authenticate(params[:user_login][:password]) 
	# 	elsif patient 
	# 		@user_login.role = "patient"
	# 		return patient.authenticate(params[:user_login][:password])
	# 	else
	# 		return false
	# 	end
	# end

	# def dashboard_path
	# 	if @user_login.role == "doctor" 
	# 		doctors_dashboard_path 
	# 	elsif @user_login.role == "patient" 
	# 		patients_dashboard_path 
	# 	else 
	# 		root_path 
	# 	end
	# end
end
