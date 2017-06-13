class AddImageToRecipe < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :main_image, :string
  end
end
