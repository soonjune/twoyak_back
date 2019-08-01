class DrugIngr < ApplicationRecord
<<<<<<< HEAD
    #약 성분과 약 연결(join table 통해서)
    has_many :drug_associations
    has_many :drugs, through: :drug_associations
    #상호작용과 연결
    has_many :drug_interactions
    has_many :interactions, through: :drug_interactions
=======
    has_and_belongs_to_many :drugs, join_table: "drug_associations", foreign_key: "drug_ingr_id", association_foreign_key: "drug_id"
>>>>>>> master
    has_and_belongs_to_many :dur_ingrs, join_table: "drug_associations", foreign_key: "drug_ingr_id", association_foreign_key: "dur_ingr_id"
end
