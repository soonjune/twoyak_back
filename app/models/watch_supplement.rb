class WatchSupplement < ApplicationRecord
    belongs_to :user
    belongs_to :watch_supplement, :class_name => "Supplement"
end
