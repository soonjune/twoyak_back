class AddMainCodeToDrugs < ActiveRecord::Migration[5.2]
  def change
    add_column :drugs, :hira_medicine_code, :integer
    add_column :drugs, :hira_main_ingr_code, :string
  end
end
