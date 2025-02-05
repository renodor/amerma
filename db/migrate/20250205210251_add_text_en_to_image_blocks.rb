class AddTextEnToImageBlocks < ActiveRecord::Migration[8.0]
  def change
    add_column :image_blocks, :title_en, :string
    add_column :image_blocks, :subtitle_en, :string
    add_column :image_blocks, :caption_en, :text
  end
end
