class TakingDrugReason < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_taking_reasons do |t|
      t.references :disease, index: true, foreign_key: true
      t.references :reasonable, polymorphic: true, index: true
    end
  end
end
