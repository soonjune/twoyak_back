class CreateInteractions < ActiveRecord::Migration[5.2]
  def change
    create_table :interactions do |t|
      #새롭게 상호작용이라는 테이블을 만든다.
      t.boolean :is_recommendation
      t.references :interactable, polymorphic: true, index: true
      t.string :title
      #info 안에는 설명, 주의사항 등이 들어갈 예정
      t.json :info
      t.json :references
      #belongs_to drug_ingrs, has many sup_items through sup_ingrs, can belong to: sup_ingrs or diseases
      #약물
      add_column :drug_ingrs, :atc_code, :string, after: 'description'
      add_column :drug_ingrs, :name_eng, :string, after: 'name'
      add_column :supplement_ingrs, :rich_foods, :json, after: 'daily_intake_min'
    end
  end
end
