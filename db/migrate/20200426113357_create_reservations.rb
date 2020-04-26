class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :table, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :from
      t.datetime :to
      t.integer :duration

      t.timestamps
    end
  end
end
