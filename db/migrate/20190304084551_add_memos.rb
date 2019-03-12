class AddMemos < ActiveRecord::Migration[5.2]
  def change
    add_column :current_drugs, :memo, :string, after: 'from'
    add_column :past_drugs, :memo, :string, after: 'from'
    add_column :past_supplements, :memo, :string, after: 'from'
    add_column :current_supplements, :memo, :string, after: 'from'
  end
end
