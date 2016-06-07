class Position < ActiveRecord::Base
    
    # Example from http://www.rubygeocoder.com/
    geocoded_by :address
    validates :address, presence: true, uniqueness: true
    
    reverse_geocoded_by :latitude, :longitude
    before_validation :geocode, :reverse_geocode
    
    after_validation :geocode, :if => :address_changed?
    
    belongs_to :pub
end
