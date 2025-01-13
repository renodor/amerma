class CreateProjectCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :project_categories do |t|
      t.string :name, null: false
      t.text :description
      t.string :icon

      t.timestamps
    end
  end
end
