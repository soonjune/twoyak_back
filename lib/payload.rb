module Payload
    extend self

    def payload(user)
        return nil unless user and user.id
        {
                    :iss => "twoyak.com",
                    :user => {id: user.id, email: user.email, user_name: user.user_infos.first.user_name, user_info_id: user.user_infos.first.id },
        }
    end

    
end