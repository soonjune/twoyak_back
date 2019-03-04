class AddSexToUserInfos < ActiveRecord::Migration[5.2]
  def change
    add_column :user_infos, :sex, :boolean
  end
end
