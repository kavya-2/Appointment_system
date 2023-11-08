class AddAppointmentDateAndDurationToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :appointment_date, :date
    add_column :appointments, :duration, :integer
  end
end
