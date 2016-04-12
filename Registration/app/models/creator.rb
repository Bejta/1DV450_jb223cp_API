class Creator < ActiveRecord::Base
    
    has_many :pubs
    has_secure_password

    validates :name,
              :presence => {:message => "du måste ange ett namn"},
              uniqueness: true

end
