class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :slot_step, default: Restaurant::DEFAULT_TIME_SLOT
      t.integer :max_reserved_period, default: Restaurant::DEFAULT_MAX_RESERVED_PERIOD
      t.string :excluded_hours

      t.timestamps
    end
  end
end
