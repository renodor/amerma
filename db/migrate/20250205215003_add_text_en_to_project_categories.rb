class AddTextEnToProjectCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :project_categories, :name_en, :string
    add_column :project_categories, :description_en, :text
  end
end
