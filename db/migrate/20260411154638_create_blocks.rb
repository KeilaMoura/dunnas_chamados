class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.string :name
      t.integer :total_floors
      t.integer :units_per_floor

      t.timestamps
    end
  end
end
