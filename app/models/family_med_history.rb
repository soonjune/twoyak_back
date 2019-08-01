class FamilyMedHistory < ApplicationRecord
  belongs_to :sub_user
  belongs_to :med_his, :class_name => "Disease"
end
