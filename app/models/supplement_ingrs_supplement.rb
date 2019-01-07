class SupplementIngrsSupplement < ApplicationRecord
  resourcify

  belongs_to :supplement
  belongs_to :supplement_ingr
end
