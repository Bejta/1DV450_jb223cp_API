class Client < ActiveRecord::Base
    #relation in a database
    belongs_to :user
    
    #validations
    validates :apikey, presence: true, uniqueness: true
    validates :user_id, presence: true
end
