class CreateDrugInteractions < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_interactions do |t|
      t.references :drug_ingr, foreign_key: true
      t.references :interaction, foreign_key: true

      t.timestamps
    end
  end
end
