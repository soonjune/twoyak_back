class CreateWatchSupplements < ActiveRecord::Migration[5.2]
  def change
    create_table :watch_supplements do |t|
      t.integer :user_id
      t.integer :watch_supplement_id

      t.timestamps
    end
  end
end
