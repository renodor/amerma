class ChangeContentBlocksContentableColumnNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :content_blocks, :contentable_id, true
    change_column_null :content_blocks, :contentable_type, true
  end
end
