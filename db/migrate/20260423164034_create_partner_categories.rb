class CreatePartnerCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :partner_categories do |t|
      t.string "name", null: false
      t.string "name_en"
      t.text "description"
      t.text "description_en"
      t.string "icon"
      t.integer "position", default: 0, null: false

      t.timestamps
    end
  end
end
