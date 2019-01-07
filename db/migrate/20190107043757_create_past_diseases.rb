class CreatePastDiseases < ActiveRecord::Migration[5.2]
  def change
    create_table :past_diseases do |t|
      t.integer :user_info_id
      t.integer :past_disease_id

      t.timestamps
    end
  end
end
