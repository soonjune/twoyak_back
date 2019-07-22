class AddDrugIngrsRefereceToInteractions < ActiveRecord::Migration[5.2]
  def change
    add_column :interactions, :drug_ingr_id, :bigint, after: 'id', index: true
  end
end
