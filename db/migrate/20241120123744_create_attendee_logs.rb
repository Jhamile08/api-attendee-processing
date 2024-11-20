class CreateAttendeeLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :attendee_logs do |t|
      t.references :attendee, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
