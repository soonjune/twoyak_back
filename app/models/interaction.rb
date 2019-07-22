class Interaction < ApplicationRecord
    belongs_to :supplement_ingr
    
    #약 성분과 상호작용 연결
    has_many :drug_interactions
    has_many :drug_ingrs, through: :drug_interactions
end
