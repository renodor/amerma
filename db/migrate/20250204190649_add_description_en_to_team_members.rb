class AddDescriptionEnToTeamMembers < ActiveRecord::Migration[8.0]
  def change
    add_column :team_members, :description_en, :text
  end
end
