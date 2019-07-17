class DrugTakingReason < ApplicationRecord
    belongs_to :reasonable, polymorphic: true
    belongs_to :disease
end
