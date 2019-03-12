class AddTo < ActiveRecord::Migration[5.2]
  def change
    add_column :current_drugs, :to, :date, after: 'current_drug_id'
    add_column :current_supplements, :to, :date, after: 'current_supplement_id'
  end
end
