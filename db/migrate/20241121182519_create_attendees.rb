class CreateAttendees < ActiveRecord::Migration[7.2]
  def change
    create_table :attendees do |t|
      t.integer :user_attendee_id
      t.string :ticket_id
      t.string :name
      t.string :email
      t.boolean :status

      t.timestamps
    end
  end
end
