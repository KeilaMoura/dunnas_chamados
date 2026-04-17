class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true
      t.references :ticket_type, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
