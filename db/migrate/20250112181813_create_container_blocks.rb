class CreateContainerBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :container_blocks do |t|
      t.integer :position, default: 0, null: false
      t.string :class_list, array: true, default: [], null: false

      t.references :containerable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
