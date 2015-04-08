class AddColumnsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :name, :string
    add_column :projects, :description, :string
    add_column :projects, :user_id, :integer


  end
end
