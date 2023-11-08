class Doctor < ApplicationRecord
	has_many :appointments
	has_one :user_login, dependent: :destroy
	has_secure_password


  validates :first_name, presence: true 
	validates :last_name, presence: true
	validates :username, presence: true, uniqueness: true  
	validates :specialization, presence: true 
	validates :years_of_experience, presence: true, numericality: { greater_than_or_equal_to: 0 } 
	validates :location, presence: true, inclusion: { in: ['Bangalore', 'Chennai', 'Hyderabad'] } 
	validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
	validates :phone_number, presence: true, format: { with: /\A\+91\s?\d{10}\z/ } 
	validates :gender, presence: true

	validates :password, presence: true, length: { minimum: 8 }
	validates :password_confirmation, presence: true, if: -> { password.present? }
end
