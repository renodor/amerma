class RenameProjectCategoryDescriptionToSummary < ActiveRecord::Migration[8.0]
  def change
    rename_column :project_categories, :description, :summary
    rename_column :project_categories, :description_en, :summary_en
    change_column :project_categories, :summary, :string, limit: 255
    change_column :project_categories, :summary_en, :string, limit: 255
  end
end
