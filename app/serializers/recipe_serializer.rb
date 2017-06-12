class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :thumbnail
  belongs_to :author
end
