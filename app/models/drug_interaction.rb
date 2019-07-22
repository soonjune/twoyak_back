class DrugInteraction < ApplicationRecord
  belongs_to :drug_ingr
  belongs_to :interaction
end
