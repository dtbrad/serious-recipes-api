class RecipesController < ApplicationController
  def index
    Recipe.populate_recipe_summaries
    # render json: Recipe.all
    render :json => Recipe.all.to_json(:only => ["id", "title", "thumbnail"])
  end

  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe
  end
end
