module Payload
    extend self

    require 'jwt'

    def jwt_encoded(user)
        { auth_token: JWT.encode(payload(user), ENV['SECRET_KEY_BASE'], 'HS256') }
    end

    def payload(user)

        return nil unless user and user.id
        {
                    :iss => "twoyak.com",
                    :user => {id: user.id, email: user.email, sub_users: user.sub_users.select(:id, :user_name).as_json },
        }
    end


end