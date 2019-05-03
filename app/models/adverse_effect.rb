class AdverseEffect < ApplicationRecord
    has_and_belongs_to_many :drug_reviews
end
