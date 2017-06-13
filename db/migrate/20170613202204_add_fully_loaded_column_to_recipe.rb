class AddFullyLoadedColumnToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :fully_loaded, :boolean, default: false
  end
end
