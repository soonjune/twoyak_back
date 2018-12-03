class DurIngr < ApplicationRecord
    has_and_belongs_to_many :drugs

    searchkick language: "korean", word: [:dur_code, :ingr_eng_name, :ingr_kor_name, :related_ingr_kor_name]

    def search_data
        {
            dur_code: dur_code,
            ingr_eng_name: ingr_eng_name,
            ingr_kor_name: ingr_kor_name,
            related_ingr_kor_name: related_ingr_kor_name
        }
    end
end
