class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|
      t.string :name
      t.boolean :is_default
      t.boolean :is_final

      t.timestamps
    end
  end
end
