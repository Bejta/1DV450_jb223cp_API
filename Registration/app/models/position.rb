class Position < ActiveRecord::Base
    
      has_many :pubs
      
      validates :address, presence: true
      
      geocoded_by :address
      after_validation :geocode, :if => :address_changed?

end
