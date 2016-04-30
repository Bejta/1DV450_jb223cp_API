class Creator < ActiveRecord::Base
    
    has_many :pubs
    has_secure_password

    
              
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name,
              :presence => {:message => "du måste ange ett namn"},
               uniqueness: true
    validates :email, presence: true, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
    validates :password, presence: true
    validates :password_confirmation, presence: true

end
