class AddDrugIngrsRefereceToInteractions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interactions, :drug_ingr, after: 'id', index: true
  end
end
