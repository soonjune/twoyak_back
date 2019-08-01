class FixColumnNameForFamilyHis < ActiveRecord::Migration[5.2]
  def change
    rename_column :prescription_photos, :user_info_id, :user_id

  end
end
