class ModifyUserAttendees < ActiveRecord::Migration[7.2]
  def change
    remove_column :user_attendees, :user_id, :integer
    add_column :user_attendees, :event_id, :integer, null: false
  end
end
