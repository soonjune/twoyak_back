class Drug < ApplicationRecord
    require 'json'

    def my_map(enumerable)
        result = []
        enumerable.each { |element| result.push *(element) }
        result
      end
      
      def eng_map(enumerable)
        result = []
        enumerable.each do |element| 
          element.ingr_eng_name.nil? ? next : result.push(*(JSON.parse(element.ingr_eng_name)))
        end
        result
      end

    has_and_belongs_to_many :dur_ingrs

    searchkick word_middle: [:item_name, :ingr_kor_name, :ingr_eng_name]

    def search_data
        {
            name: item_name,
            ingr_kor_name: eng_map(my_map(ingr_kor_name)),
            ingr_eng_name: JSON.parse(ingr_eng_name)
        }
    end
end
