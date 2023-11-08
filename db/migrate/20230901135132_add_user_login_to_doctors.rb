class AddUserLoginToDoctors < ActiveRecord::Migration[7.0]
  def change
    add_reference :doctors, :user_login, foreign_key: true
  end
end
