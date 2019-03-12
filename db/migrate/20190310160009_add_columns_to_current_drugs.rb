class AddColumnsToCurrentDrugs < ActiveRecord::Migration[5.2]
  def up
    add_column :current_drugs, :how, :string, after: 'current_drug_id'
    add_column :current_drugs, :when, :string, after: 'current_drug_id'
  end

  def down
    remove_column :current_drugs, :how, :string
    remove_column :current_drugs, :when, :string
  end
end
