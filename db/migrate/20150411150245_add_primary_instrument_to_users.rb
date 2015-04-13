class AddPrimaryInstrumentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_instrument, :string
  end
end
