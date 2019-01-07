class DrugsDurIngr < ApplicationRecord
  resourcify

  belongs_to :drug
  belongs_to :dur_ingr
end
