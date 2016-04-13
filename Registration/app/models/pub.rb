class Pub < ActiveRecord::Base
    
    validates :name, presence: true, length: { maximum: 50}
    validates :description, presence: true, length: { maximum: 500}
    validates :rating, presence: true, :numericality => {:greater_than_or_equal => 1, :less_than => 6}
    validates :creator_id,  presence: true
    
    has_many :positions
    has_and_belongs_to_many :tags
    belongs_to :creator
end
