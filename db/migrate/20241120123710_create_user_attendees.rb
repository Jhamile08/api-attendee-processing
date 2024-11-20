class CreateUserAttendees < ActiveRecord::Migration[7.2]
  def change
    create_table :user_attendees do |t|
      t.references :api_user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
