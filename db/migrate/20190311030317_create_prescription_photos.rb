class CreatePrescriptionPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :prescription_photos do |t|
      t.references :user_info
      t.string :url
    end
  end
end
