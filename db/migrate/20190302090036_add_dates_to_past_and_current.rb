class AddDatesToPastAndCurrent < ActiveRecord::Migration[5.2]
  def change
    add_column :current_diseases, :from, :date, after: 'current_disease_id'
    add_column :past_diseases, :from, :date, after: 'past_disease_id'
    add_column :past_diseases, :to, :date, after: 'past_disease_id'
    add_column :current_drugs, :from, :date, after: 'current_drug_id'
    add_column :past_drugs, :from, :date, after: 'past_drug_id'
    add_column :past_drugs, :to, :date, after: 'past_drug_id'
    add_column :current_supplements, :from, :date, after: 'current_supplement_id'
    add_column :past_supplements, :from, :date, after: 'past_supplement_id'
    add_column :past_supplements, :to, :date, after: 'past_supplement_id'
  end
end
