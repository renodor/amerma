class CreateImageBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :image_blocks do |t|
      t.string :title
      t.string :subtitle
      t.text :caption

      t.timestamps
    end
  end
end
