class AddDurInfoToDrugs < ActiveRecord::Migration[5.2]
  def change
    add_column :drugs, :dur_info, :json, after: 'package_insert'
  end
end
