class CreatePartners < ActiveRecord::Migration[8.0]
  def change
    create_table :partners do |t|
      t.string :name, null: false
      t.text :description
      t.string :website_url

      t.timestamps
    end
  end
end
