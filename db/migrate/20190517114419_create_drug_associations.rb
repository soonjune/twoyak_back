class CreateDrugAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_associations do |t|
      t.references :drug
      t.references :drug_ingr
      t.references :dur_ingr

      t.timestamps
    end
  end
end
