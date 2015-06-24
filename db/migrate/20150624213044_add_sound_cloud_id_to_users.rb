class AddSoundCloudIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :soundcloud_id, :string
  end
end
