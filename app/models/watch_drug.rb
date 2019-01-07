class WatchDrug < ApplicationRecord
    belongs_to :user
    belongs_to :watch_drug, :class_name => "Drug"
end
