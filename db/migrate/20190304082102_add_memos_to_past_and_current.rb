class AddMemosToPastAndCurrent < ActiveRecord::Migration[5.2]
  def change
    add_column :current_drugs, :memo, :string, before: 'created_at'
    add_column :past_drugs, :memo, :string, before: 'created_at'
    add_column :past_supplements, :memo, :string, before: 'created_at'
    add_column :current_supplements, :memo, :string, before: 'created_at'
  end
end
