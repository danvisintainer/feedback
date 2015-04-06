class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.attachment :audio
      t.timestamps null: false
    end
  end
end
