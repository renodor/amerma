class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :featured, null: false, default: false

      t.references :project_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
