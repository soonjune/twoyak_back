class CreateCurrentSupplements < ActiveRecord::Migration[5.2]
  def change
    create_table :current_supplements do |t|
      t.integer :user_info_id
      t.integer :current_supplement_id

      t.timestamps
    end
  end
end
