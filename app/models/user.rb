class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  
    has_many :user_infos
    has_many :reviews
    has_many :watch_drugs, :class_name => "Drug", :foreign_key => "watch_drug_id"
    has_many :watch_supplements, :class_name => "Supplement", :foreign_key => "watch_supplement_id"
  
  
    # #user당 최소 user_info 하나
    # validates :user_infos, presence: true
    #이메일 형식
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true,
    length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  
  end
  