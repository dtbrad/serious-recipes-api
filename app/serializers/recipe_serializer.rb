class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :thumbnail, :main_image
  belongs_to :author
  has_many :directions
  has_many :ingredients
end
