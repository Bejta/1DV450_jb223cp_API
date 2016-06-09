class CreatorSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :links

  def links
    {
      pubs: api_creator_pubs_path(object.id)
    }
  end
end