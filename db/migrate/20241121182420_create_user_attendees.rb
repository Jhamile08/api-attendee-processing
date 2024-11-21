class CreateUserAttendees < ActiveRecord::Migration[7.2]
  def change
    create_table :user_attendees do |t|
      t.integer :user_id, null: false
      t.integer :quantity_tickets

      t.timestamps
    end
  end
end
