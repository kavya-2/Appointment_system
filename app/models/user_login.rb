class UserLogin < ApplicationRecord
	belongs_to :patient, optional: true 
	belongs_to :doctor, optional: true
	validates :username, presence: true, uniqueness: true 
	validates :password, presence: true
end
