class AddVisibleToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :visible, :boolean, default: false, null: false
  end
end
