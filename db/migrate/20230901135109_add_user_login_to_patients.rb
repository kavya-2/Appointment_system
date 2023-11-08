class AddUserLoginToPatients < ActiveRecord::Migration[7.0]
  def change
    add_reference :patients, :user_login, foreign_key: true
  end
end
