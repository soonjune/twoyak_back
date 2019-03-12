class AddColumnsToDrugs < ActiveRecord::Migration[5.2]
  def change
    add_column :drugs, :short_notice, :string, after: 'ingr_kor_name'
    add_column :drugs, :short_description, :string, after: 'ingr_kor_name'
  end
end
