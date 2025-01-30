class AddOwnerToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :owner, :string
  end
end
