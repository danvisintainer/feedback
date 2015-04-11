class DeleteColumnLookingFor < ActiveRecord::Migration
  def change
    remove_column :projects, :looking_for
  end
end
