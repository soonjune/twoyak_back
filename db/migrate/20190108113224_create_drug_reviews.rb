class CreateDrugReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :drug_reviews do |t|
      t.references :user
      t.references :drug
      t.integer :efficacy
      t.integer :side_effect
      t.text :body
      t.json :pics

      t.timestamps
    end
  end
end
