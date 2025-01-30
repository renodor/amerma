class AddColumnCountToContainerBlocks < ActiveRecord::Migration[8.0]
  def change
    add_column :container_blocks, :column_count, :integer, default: 1, null: false
  end
end
