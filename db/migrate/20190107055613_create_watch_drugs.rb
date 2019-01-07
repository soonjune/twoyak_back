class CreateWatchDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :watch_drugs do |t|
      t.integer :user_id
      t.integer :watch_drug_id

      t.timestamps
    end
  end
end
