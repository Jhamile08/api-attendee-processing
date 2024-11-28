class CreateAttendeeRules < ActiveRecord::Migration[7.2]
  def change
    create_table :attendee_rules do |t|
      t.integer :user_attendee_id
      t.integer :event_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
