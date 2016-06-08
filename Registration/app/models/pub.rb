class Pub < ActiveRecord::Base
    belongs_to :creator
    belongs_to :position
    
    has_and_belongs_to_many :tags
    
    validates :name, presence: true, length: { maximum: 50}
    validates :description, presence: true, length: { maximum: 500}
    validates :rating, presence: true, :numericality => {:greater_than_or_equal => 1, :less_than => 6}
    #validates :creator_id, presence: true
    #validates :position_id, presence: true
    
    
end
