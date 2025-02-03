class AddLocationToContainer < ActiveRecord::Migration[8.0]
  def change
    add_column :container_blocks, :location, :string
  end
end
