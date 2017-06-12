class RecipesController < ApplicationController
  def index
    Recipe.populate_recipe_summaries
    render json: Recipe.all
  end
end
