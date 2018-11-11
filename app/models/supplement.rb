class Supplement < ApplicationRecord
    has_and_belongs_to_many :supplement_ingrs
end
