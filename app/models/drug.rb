class Drug < ApplicationRecord
    has_and_belongs_to_many :dur_ingrs

    searchkick word_middle: [:item_name, :ingr_kor_name, :ingr_eng_name]

    def search_data
        {
            name: item_name,
            ingredients: ingr_kor_name,
            ingredients: ingr_eng_name
        }
    end
end
