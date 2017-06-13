class Recipe < ApplicationRecord
  has_many :ingredients
  has_many :directions
  belongs_to :author

  def self.populate_recipe_summaries
    Scraper.latest_summaries.each do |sr|
      build_recipe(sr)
    end
  end

  def self.build_recipe(recipe_hash)
    recipe = Recipe.find_or_create_by(recipe_hash[:recipe])
    recipe.author = Author.find_or_create_by(recipe_hash[:author])
    recipe.save
    recipe.build_details unless recipe.fully_loaded == true
  end

  def build_details
    details = Scraper.get_full_recipe(url)
    description = details[:recipe_description]
    image = details[:recipe_image]
    directions = make_directions(id, details[:recipe_directions])
    ingredients = make_ingredients(id, details[:recipe_ingredients])
    update(description: description, main_image: image, fully_loaded: true)
  end

  def make_directions(id, directions)
    directions.each do |direction|
      place = directions.find_index(direction) + 1
      Direction.find_or_create_by(place: place, content: direction, recipe_id: id)
    end
  end

  def make_ingredients(id, ingredients)
    ingredients.each do |ingredient|
      Ingredient.find_or_create_by(recipe_id: id, name: ingredient)
    end
  end

end
