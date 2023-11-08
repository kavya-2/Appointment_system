class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :specialization
      t.integer :years_of_experience
      t.string :location
      t.string :email
      t.string :phone_number
      t.string :gender

      t.timestamps
    end
  end
end
