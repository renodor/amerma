class CreateTextBlocks < ActiveRecord::Migration[8.0]
  def change
    create_table :text_blocks do |t|
      t.timestamps
    end
  end
end
