class Disease < ApplicationRecord
    belongs_to :med_his, :class_name => "UserInfo"
    belongs_to :past_disease, :class_name => "UserInfo"
    belongs_to :current_disease, :class_name => "UserInfo"
end
