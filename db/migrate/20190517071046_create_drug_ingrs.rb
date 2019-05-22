class CreateDrugIngrs < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_ingrs do |t|
      t.string :name
      t.json :description

      t.timestamps
    end
  end
end
