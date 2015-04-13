class AddLookingForProjects < ActiveRecord::Migration
  def change
    add_column :projects, :looking_for, :string
  end
end
