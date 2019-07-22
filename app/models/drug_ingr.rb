class DrugIngr < ApplicationRecord
    #약 성분과 약 연결(join table 통해서)
    has_many :drug_associations
    has_many :drugs, through: :drug_associations
    has_and_belongs_to_many :dur_ingrs, join_table: "drug_associations", foreign_key: "drug_ingr_id", association_foreign_key: "dur_ingr_id"
end
