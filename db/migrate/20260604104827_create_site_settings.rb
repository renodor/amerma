class CreateSiteSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :site_settings do |t|
      t.timestamps
    end
  end
end
