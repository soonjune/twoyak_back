class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :confirmable, :trackable, :omniauthable,
           :omniauth_providers => [:facebook, :google_oauth2, :naver]
  
    has_many :user_infos
    has_many :reviews
    has_many :watch_drugs, :class_name => "Drug", :foreign_key => "watch_drug_id"
    has_many :watch_supplements, :class_name => "Supplement", :foreign_key => "watch_supplement_id"
  
    has_many :identities, dependent: :destroy
  
  
    #이메일 형식
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,
    length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    
    # after_create :set_default_role, if: Proc.new { User.count > 1 }
  
    TEMP_EMAIL_PREFIX = 'change@me'
    TEMP_EMAIL_REGEX = /\Achange@me/
  
    #소셜 로그인시 두개로 로그인하지 않도록
    def self.find_for_oauth(auth, signed_in_resource = nil)
  
      # Get the identity and user if they exist
      identity = Identity.find_for_oauth(auth)
  
      # If a signed_in_resource is provided it always overrides the existing user
      # to prevent the identity being locked with accidentally created accounts.
      # Note that this may leave zombie accounts (with no associated identity) which
      # can be cleaned up at a later date.
      user = signed_in_resource ? signed_in_resource : identity.user
  
      # Create the user if needed
      if user.nil?
  
        # Get the existing user by email if the provider gives us a verified email.
        # If no verified email was provided we assign a temporary email and ask the
        # user to verify it on the next step via UsersController.finish_signup
        email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
        email = auth.info.email if email_is_verified
        user = User.where(:email => email).first if email
  
              # Create the user if it's a new registration
        if user.nil?
          user = User.new(
            email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
            password: Devise.friendly_token[0,20]
          )
          user.skip_confirmation!
          user.save!
        end
      end
  
          # Associate the identity with the user if needed
          if identity.user != user
            identity.user = user
            identity.save!
          end
      
          user
      
        end
      
        def email_verified?
          self.email && self.email !~ TEMP_EMAIL_REGEX
        end
      
        # private
        # def set_default_role
        #   add_role :user
        # end
  
  end  