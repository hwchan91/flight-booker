class CreatePassengers < ActiveRecord::Migration[5.1]
  def change
    create_table :passengers do |t|
      t.integer :booking_id
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :passengers, :name
    add_index :passengers, :email
  end
end
