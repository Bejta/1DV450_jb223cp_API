class Tag < ActiveRecord::Base
    
    validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
    
    has_and_belongs_to_many :pubs
    
end
