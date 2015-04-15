class AddOtherToInstrumentNeeds < ActiveRecord::Migration
  def change
    add_column :instrument_needs, :other, :string, :default => "0" 
  end
end
