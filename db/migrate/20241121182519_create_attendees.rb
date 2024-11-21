class CreateAttendees < ActiveRecord::Migration[7.2]
  def change
    create_table :attendees do |t|
      t.references :user_attendee, null: false, foreign_key: true
      t.string :ticket_id
      t.string :name
      t.string :email
      t.boolean :status

      t.timestamps
    end
  end
end
