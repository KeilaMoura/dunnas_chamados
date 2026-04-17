class AddCompletedAtToTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :completed_at, :datetime
  end
end
