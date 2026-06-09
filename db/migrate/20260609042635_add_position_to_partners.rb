class AddPositionToPartners < ActiveRecord::Migration[8.0]
  def change
    add_column :partners, :position, :integer, null: false, default: 0
  end
end
