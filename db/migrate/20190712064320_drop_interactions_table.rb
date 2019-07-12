class DropInteractionsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :drug_supplement_interactions
    drop_table :interactions
  end
end
