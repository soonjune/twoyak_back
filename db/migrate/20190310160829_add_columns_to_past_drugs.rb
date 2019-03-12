class AddColumnsToPastDrugs < ActiveRecord::Migration[5.2]
    def up
      add_column :past_drugs, :how, :string, after: 'past_drug_id'
      add_column :past_drugs, :when, :string, after: 'past_drug_id'
    end
  
    def down
      remove_column :past_drugs, :how, :string
      remove_column :past_drugs, :when, :string
    end
end
