class AddTextEnToPartners < ActiveRecord::Migration[8.0]
  def change
    add_column :partners, :description_en, :text
  end
end
