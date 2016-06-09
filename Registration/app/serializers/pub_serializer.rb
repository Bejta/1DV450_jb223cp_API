class PubSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :rating, :links
  has_one :position
  has_many :tags
  has_one :creator

  def links
    {
      self: api_pub_path(object.id),
      tags: api_pub_tags_path(object.id),
      creator: api_creator_path(object.creator.id),
      position: api_position_path(object.position.id),
    }
  end
end