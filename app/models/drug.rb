class Drug < ApplicationRecord
    has_and_belongs_to_many :dur_ingrs
end
