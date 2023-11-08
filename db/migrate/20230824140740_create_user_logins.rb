class CreateUserLogins < ActiveRecord::Migration[7.0]
  def change
    create_table :user_logins do |t|
      t.string :username
      t.string :password
      t.string :role

      t.timestamps
    end
  end
end
