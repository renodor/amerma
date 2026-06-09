class AddPositionToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :position, :integer, default: 0, null: false
  end
end
