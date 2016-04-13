class Position < ActiveRecord::Base
    
    # Example from http://www.rubygeocoder.com/
    geocoded_by :address
    validates :address, presence: true, uniqueness: true
    
    after_validation :geocode, :if => :address_changed?
    
    t.belongs_to :pub, index: true
end
