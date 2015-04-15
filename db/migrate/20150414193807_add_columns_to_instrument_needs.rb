class AddColumnsToInstrumentNeeds < ActiveRecord::Migration
  def change
    add_column :instrument_needs, :vocals, :string, :default => "0" 
    add_column :instrument_needs, :saxophone, :string, :default => "0" 
  end
end
