class AddSummaryToProjects < ActiveRecord::Migration[8.0]
  def change
    add_column :projects, :summary, :string, limit: 255
    add_column :projects, :summary_en, :string, limit: 255
  end
end
