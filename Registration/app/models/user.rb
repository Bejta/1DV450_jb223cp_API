class User < ActiveRecord::Base
    #hash password in a database
    has_secure_password
    
    #relation in a database
    has_many :clients
    
    #regex for valid email format
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    #email and username saved with small letters
    before_save { self.email = email.downcase }
    before_save { self.username = username.downcase }
    
    #validation of email adress
    validates :email, presence: {:message => "Enter your email adress"}, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    validates  :username, presence: {:message => "Enter your username!"}, uniqueness:  { case_sensitive: false }, length:  { maximum: 25 }
                             
end
