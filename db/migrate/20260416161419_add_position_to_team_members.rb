class AddPositionToTeamMembers < ActiveRecord::Migration[8.0]
  def change
    add_column :team_members, :position, :integer, null: false, default: 0
  end
end
