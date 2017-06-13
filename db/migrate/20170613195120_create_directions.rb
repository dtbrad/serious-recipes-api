class CreateDirections < ActiveRecord::Migration[5.1]
  def change
    create_table :directions do |t|
      t.integer :recipe_id
      t.integer :place
      t.text :content

      t.timestamps
    end
  end
end
