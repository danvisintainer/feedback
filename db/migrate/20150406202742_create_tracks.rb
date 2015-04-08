class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.attachment :audio
      t.string :name
      t.string :description
      t.integer :user_id
      t.integer :project_id
      t.timestamps null: false
    end
  end
end
