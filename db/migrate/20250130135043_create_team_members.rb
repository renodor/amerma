class CreateTeamMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :team_members do |t|
      t.string :name, null: false
      t.text :description
      t.string :linked_in_url

      t.timestamps
    end
  end
end
