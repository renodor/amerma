class AddIsRawHtmlToTextBlock < ActiveRecord::Migration[8.0]
  def change
    add_column :text_blocks, :is_raw_html, :boolean, default: false, null: false
  end
end
