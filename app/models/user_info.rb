class UserInfo < ApplicationRecord
    belongs_to :user
    has_many :family_med_history, :class_name => "Disease", :foreign_key => "med_his_id"
    has_many :past_diseases, :class_name => "Disease", :foreign_key => "past_disease_id"
    has_many :current_diseases, :class_name => "Disease", :foreign_key => "current_disease_id"
    has_many :past_drugs, :class_name => "Drug", :foreign_key => "past_drug_id"
    has_many :past_supplements, :class_name => "Supplement", :foreign_key => "past_supplement_id"
    has_many :current_drugs, :class_name => "Drug", :foreign_key => "current_drug_id"
    has_many :current_supplements, :class_name => "Supplement", :foreign_key => "current_supplement_id"

end
