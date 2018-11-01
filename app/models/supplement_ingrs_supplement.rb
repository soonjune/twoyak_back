class SupplementIngrsSupplement < ApplicationRecord
  belongs_to :supplement
  belongs_to :supplement_ingr
end
