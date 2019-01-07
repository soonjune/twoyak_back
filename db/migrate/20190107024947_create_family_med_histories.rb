class CreateFamilyMedHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :family_med_histories do |t|
      t.integer :user_info_id
      t.integer :med_his_id

      t.timestamps
    end
  end
end
