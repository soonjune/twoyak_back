class Interaction < ApplicationRecord
    require 'json'

    def kor_map(enumerable)
        result = []
        if(enumerable.class == String)
            JSON.parse(enumerable).each do |element| 
            element.nil? ? next : result.push(*(element))
            end
        else
            enumerable.each do |element| 
            element.nil? ? next : result.push(*(element))
            end
        end
        result
    end

    searchkick language: "korean", word_middle: [:first_ingr, :second_ingr]


    def search_data
        {
            first_ingr: kor_map(first_ingr),
            second_ingr: kor_map(second_ingr)
        }
    end
end
