class FamilyMedHistory < ApplicationRecord
  belongs_to :user_info
  belongs_to :med_his, :class_name => "Disease"
end
