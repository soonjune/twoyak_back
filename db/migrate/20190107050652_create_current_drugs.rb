class CreateCurrentDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :current_drugs do |t|
      t.integer :user_info_id
      t.integer :current_drug_id

      t.timestamps
    end
  end
end
