class AddUsernameToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :username, :string
  end
end
