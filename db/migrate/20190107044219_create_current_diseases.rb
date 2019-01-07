class CreateCurrentDiseases < ActiveRecord::Migration[5.2]
  def change
    create_table :current_diseases do |t|
      t.integer :user_info_id
      t.integer :current_disease_id

      t.timestamps
    end
  end
end
