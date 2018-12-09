class SupplementIngr < ApplicationRecord
    has_and_belongs_to_many :supplements

    searchkick language: "korean", word_middle: [:ingr_name]


    def search_data
        {
            ingr_name: ingr_name
        }
    end
end
