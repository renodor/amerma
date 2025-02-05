class AddTextEnToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :name_en, :string
    add_column :projects, :description_en, :text
  end
end
