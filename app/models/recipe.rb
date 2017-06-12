class Recipe < ApplicationRecord
  has_many :ingredients
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
  end
end
