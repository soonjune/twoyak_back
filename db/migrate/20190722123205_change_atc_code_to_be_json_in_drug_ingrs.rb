class ChangeAtcCodeToBeJsonInDrugIngrs < ActiveRecord::Migration[5.2]
  def change
    change_column :drug_ingrs, :atc_code, :json
  end
end
