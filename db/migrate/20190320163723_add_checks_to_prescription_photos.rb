class AddChecksToPrescriptionPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :prescription_photos, :check, :string
  end
end
