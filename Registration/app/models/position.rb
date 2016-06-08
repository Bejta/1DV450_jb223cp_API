class Position < ActiveRecord::Base
    
      # Example from http://www.rubygeocoder.com/
    
      has_many :pubs


      validates :address, presence: true
      
      geocoded_by :address
      after_validation :geocode, :if => :address_changed?

end
