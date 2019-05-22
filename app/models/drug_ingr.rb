class DrugIngr < ApplicationRecord
    has_and_belongs_to_many :drugs, join_table: "drug_associations", foreign_key: "drug_ingr_id", association_foreign_key: "drug_id"
    has_and_belongs_to_many :dur_ingrs, join_table: "drug_associations", foreign_key: "drug_ingr_id", association_foreign_key: "dur_ingr_id"
end
