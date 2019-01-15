class Supplement < ApplicationRecord
    resourcify

    has_and_belongs_to_many :supplement_ingrs
    has_many :pasts, :class_name => "PastSupplement", :foreign_key => "past_supplement_id"
    has_many :currents, :class_name => "CurrentSupplement", :foreign_key => "current_supplement_id"
    #리뷰
    has_many :reviews, :class_name => "SupReview"
    
    searchkick language: "korean", word_middle: [:product_name, :ingredients]
    

    def search_data
        {
            name: product_name,
            ingredients: ingredients
        }
    end

end
