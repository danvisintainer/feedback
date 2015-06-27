class AddSoundcloudToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :uploaded, :boolean, :default => false
    add_column :projects, :soundcloud_id, :string
    add_column :projects, :soundcloud_url, :string
  end
end
