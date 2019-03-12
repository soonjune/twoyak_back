class FixColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :drugs, :item_name, :name
    rename_column :supplements, :product_name, :name
    rename_column :diseases, :disease_name, :name

  end
end
