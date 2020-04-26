class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.integer :number
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
