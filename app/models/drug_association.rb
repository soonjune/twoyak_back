class DrugAssociation < ApplicationRecord
<<<<<<< HEAD
    belongs_to :drug
    belongs_to :drug_ingr
    belongs_to :dur_ingr, optional: true
    validates_uniqueness_of :drug_id, :scope => [:drug_ingr_id, :dur_ingr_id]
=======
  belongs_to :drug
  belongs_to :drug_ingr
  belongs_to :dur_ingr
>>>>>>> master
end
