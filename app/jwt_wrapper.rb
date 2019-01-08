# Helper module for you to use on your app and in your Strategy
# Don't add "Helper" to its name and rails won't load it has a view helper module.
# "app/helpers/jwt_wrapper.rb"

module JWTWrapper
    extend self
  
    def encode(payload)
  
      payload = payload.dup
  
      JWT.encode payload, ENV['SECRET_KEY_BASE']
    end
  
    def decode(token)
      begin
        decoded_token = JWT.decode token, ENV['SECRET_KEY_BASE'], true, { iss: "twoyak.com", verify_iss: true }
  
        decoded_token.first
      rescue
        nil
      end
    end
  end