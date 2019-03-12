class AddToToCurrentDiseases < ActiveRecord::Migration[5.2]
  def change
    add_column :current_diseases, :to, :date, after: 'current_disease_id'
  end
end
