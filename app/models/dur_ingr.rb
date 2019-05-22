class DurIngr < ApplicationRecord
    resourcify

    # has_and_belongs_to_many :drugs

    has_and_belongs_to_many :drug_ingrs, join_table: "drug_associations", foreign_key: "dur_ingr_id", association_foreign_key: "drug_ingr_id"
    has_and_belongs_to_many :drugs, join_table: "drug_associations", foreign_key: "dur_ingr_id", association_foreign_key: "drug_id"

    searchkick language: "korean", word: [:dur_code, :ingr_eng_name, :ingr_kor_name, :related_ingr_kor_name]

    def search_data
        {
            dur_code: dur_code,
            ingr_eng_name: ingr_eng_name,
            ingr_eng_name_lo: ingr_eng_name.downcase,
            ingr_kor_name: ingr_kor_name,
            related_ingr_kor_name: related_ingr_kor_name
        }
    end
end
