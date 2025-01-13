class CreateContentBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :content_blocks do |t|
      t.integer :position, default: 0, null: false
      t.string :class_list, array: true, default: [], null: false

      t.references :container_block, foreign_key: true, null: false
      t.references :contentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
