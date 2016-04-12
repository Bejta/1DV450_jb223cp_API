class Client < ActiveRecord::Base
    #relation in a database
    belongs_to :user
    has_many :pubs
    
    #before_create :generate_apikey
    
    #validations
    validates :apikey, presence: true, uniqueness: true
    validates :user_id, presence: true
    
    validates :name, presence: {:message => "Enter the name of your client"}, uniqueness: true
    validates  :url, presence: {:message => "Enter a url of your client"}, uniqueness: true

    
end
