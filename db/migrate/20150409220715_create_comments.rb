class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :body
      t.references :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :comments, :projects
  end
end
