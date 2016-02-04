class Client < ActiveRecord::Base
    #relation in a database
    belongs_to :user
    
    before_create :generate_apikey
    
    #validations
    validates :apikey, presence: true, uniqueness: true
    validates :user_id, presence: true
    
    # about creating api key: https://bubblogging.wordpress.com/2014/01/10/ror-authentication-token/
    def generate_apikey
      begin
        self.aapikey = SecureRandom.hex
      end while self.class.exists?(apikey: apikey)
    end
end
