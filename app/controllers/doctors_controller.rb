class DoctorsController < ApplicationController
	# before_action :require_login, except: [:new, :create]
	
	def new
		@doctor = Doctor.new
		render :new
	end

	def create
		@doctor = Doctor.create(doctor_params)
		if @doctor.persisted? 
			redirect_to doctors_dashboard_path 
		else 
			flash[:errors] = @doctor.errors.full_messages
			render :new, status: :unprocessable_entity, content_type: "text/html"
		end
	end

	def dashboard
		@doctor = Doctor.find(session[:user_id])
		@appointments = @doctor.appointments.includes(:patient)
		if @appointments.empty? 
			flash.now[:notice] = "You have no appointments at the moment."
		end
	end

	def show_appointment 
		@appointment = Appointment.find(params[:id]) 
	end
	
	def approve_appointment 
		@doctor = Doctor.find(session[:user_id])
		@appointment = @doctor.appointments.find(params[:appointment_id]) 
		@appointment.update(update_params(status: "approved")) 
		redirect_to show_appointment_doctor_appointment_path(@appointment) 
	end
	
	def decline_appointment 
		@doctor = Doctor.find(session[:user_id])
		@appointment = @doctor.appointments.find(params[:appointment_id]) 
		@appointment.update(update_params(status: "declined")) 
		redirect_to show_appointment_doctor_appointment_path(@appointment)  
	end
	
	private

	def doctor_params 
		params.require(:doctor).permit(:first_name, :last_name, :username, :specialization, :years_of_experience, :location, :email, :phone_number, :gender, :password, :password_confirmation) 
	end

	def update_params(attributes) 
		params.permit(:appointment_id).merge(attributes) 
	end
	
	def require_login
		unless logged_in? && current_user.doctor? 
			flash[:error] = "You must be logged in as a doctor to access this page" 
			redirect_to root_path 
		end
	end
end
