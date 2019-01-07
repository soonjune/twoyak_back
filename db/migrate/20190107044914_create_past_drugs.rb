class CreatePastDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :past_drugs do |t|
      t.integer :user_info_id
      t.integer :past_drug_id

      t.timestamps
    end
  end
end
