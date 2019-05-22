class DrugAssociation < ApplicationRecord
  belongs_to :drug
  belongs_to :drug_ingr
  belongs_to :dur_ingr
end
