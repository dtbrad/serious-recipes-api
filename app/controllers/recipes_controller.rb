class RecipesController < ApplicationController
  def index
    Recipe.populate_recipe_summaries
    @recipes = Recipe.order(created_at: :desc)
    render :json => @recipes.to_json(:only => ["id", "title", "thumbnail"])
  end

  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe
  end
end
