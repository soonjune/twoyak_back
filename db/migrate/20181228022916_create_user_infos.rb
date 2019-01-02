class CreateUserInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.references :user, index: true, foregin_key: true
      t.string :user_name, null: false
      t.string :profile_image
      t.date :birth_date
      t.boolean :drink
      t.boolean :smoke
      t.boolean :caffeine

      t.timestamps


    end
  end
end