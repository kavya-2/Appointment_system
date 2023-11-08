class AppointmentsController < ApplicationController
	# before_action :authenticate_patient!, only: [:create]

	def index
		@appointment = Appointment.new
		@doctors = Doctor.where(specialization: params[:specialization])
		@patient = Patient.find(session[:user_id])
	end

	# def create
	# 	doctor = Doctor.find(params[:doctor_id]) 
	# 	if doctor.available? 
	# 		appointment = current_user.patient.appointments.build(doctor: doctor) 
	# 		if appointment.save 
	# 			redirect_to patient_dashboard_path, notice: "Appointment booked successfully"
	# 		else 
	# 			redirect_to patient_dashboard_path, alert: "Failed to book appointment"
	# 		end
	# 	else 
	# 		redirect_to patient_dashboard_path, alert: "This appointment is already booked"
	# 	end
	# end

	def create
		@appointment = Appointment.new(appointment_params) 
		if @appointment.save 
			redirect_to appointments_path, notice: "Appointment created successfully."
		else 
			# flash.now[:alert] = "Error creating appointment." 
			flash[:errors] = @appointment.errors.full_messages
			render :index, status: :unprocessable_entity, content_type: "text/html"
		end
	end

	private
	def appointment_params 
		params.require(:appointment).permit(:patient_id, :doctor_id, :appointment_date, :duration) 
	end

	def authenticate_patient!
		redirect_to root_path unless current_user&.patient?
	end

	def set_doctor
    @doctor_appointments = Appointment.where(doctor_id: params[:doctor_id])
  end
end
