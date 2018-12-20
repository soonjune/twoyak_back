class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :efficacy
      t.integer :side_effect
      t.text :body
      
      t.timestamps
    end
  end
end
