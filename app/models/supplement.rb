class Supplement < ApplicationRecord

    has_and_belongs_to_many :supplement_ingrs
    
    searchkick language: "korean", word_middle: [:product_name, :ingredients]

    def search_data
        {
            name: product_name,
            ingredients: ingredients
        }
    end

end
