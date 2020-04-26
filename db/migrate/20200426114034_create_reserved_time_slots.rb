class CreateReservedTimeSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :reserved_time_slots do |t|
      t.references :reservation, foreign_key: true
      t.references :table, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
