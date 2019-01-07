class CreatePastSupplements < ActiveRecord::Migration[5.2]
  def change
    create_table :past_supplements do |t|
      t.integer :user_info_id
      t.integer :past_supplement_id

      t.timestamps
    end
  end
end
