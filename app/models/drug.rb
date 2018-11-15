class Drug < ApplicationRecord
    require 'json'

    has_and_belongs_to_many :dur_ingrs

    searchkick word_middle: [:item_name, :ingr_kor_name, :ingr_eng_name]

    def search_data
        {
            name: item_name,
            ingr_kor_name: JSON.parse(ingr_kor_name),
            ingr_eng_name: JSON.parse(ingr_eng_name)
        }
    end
end
