class PatientsController < ApplicationController
	# before_action :require_login, except: [:new, :create]
	
	def new
		@patient = Patient.new
		render :new
	end
	
	def create
		@patient = Patient.create(patient_params) 
		if @patient.persisted?
			redirect_to patients_dashboard_path 
		else 
			flash[:errors] = @patient.errors.full_messages
			render :new, status: :unprocessable_entity, content_type: "text/html"
		end
	end

	# def dashboard
	# 	@patient = current_user 
	# 	@appointments = @patient.appointments.includes(:doctor) 
	# end
	
	# def search_doctors
	# 	@doctors = Doctor.where(specialization: params[:specialization]) 
	# 	@patient = current_user 
	# 	@appointments = @patient.appointments.includes(:doctor) 
	# 	render :dashboard
	# end

	def dashboard
		@patient = Patient.find(session[:user_id])
		@appointments = @patient.appointments.includes(:doctor)
		if @appointments.empty?
			flash[:notice] = "No appointments found for this patient."
		end
		@doctors = Doctor.all
	end
	
	def search_doctors
		@patient = Patient.find(session[:user_id])
		@doctors = Doctor.where(specialization: params[:specialization])
		@appointments = @patient.appointments.includes(:doctor)  
	end
	
	private
	
	def patient_params 
		params.require(:patient).permit(:first_name, :last_name, :username, :email, :phone_number, :gender, :password, :password_confirmation) 
	end

	def require_login
		unless logged_in? && current_user.patient? 
			flash[:error] = "You must be logged in as a patient to access this page" 
			redirect_to root_path 
		end
  end
end
