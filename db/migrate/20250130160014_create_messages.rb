class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone
      t.string :organisation
      t.text :body, null: false

      t.timestamps
    end
  end
end
