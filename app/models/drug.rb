class Drug < ApplicationRecord
    require 'json'
      
      def kor_map(enumerable)
        result = []
        if(!enumerable.nil?)
            JSON.parse(enumerable).each do |element| 
            element.nil? ? next : result.push(*(element))
            end
        end
        result
      end

      def eng_map(enumerable)
        if(!enumerable.nil?)
            a = JSON.parse(enumerable)
        end
        a
      end

    has_and_belongs_to_many :dur_ingrs
    has_one :drug_imprint

    searchkick language: "korean", word_middle: [:item_name, :ingr_kor_name, :ingr_eng_name]


    def search_data
        {
            name: item_name,
            ingr_kor_name: kor_map(ingr_kor_name),
            ingr_eng_name: eng_map(ingr_eng_name)
        }
    end
end
