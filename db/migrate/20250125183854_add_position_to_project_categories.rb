class AddPositionToProjectCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :project_categories, :position, :integer, null: false, default: 0
  end
end
