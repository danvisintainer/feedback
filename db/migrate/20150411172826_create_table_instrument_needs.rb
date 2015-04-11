class CreateTableInstrumentNeeds < ActiveRecord::Migration
  def change
    create_table :instrument_needs do |t|
      t.string :guitar, :default => "0"
      t.string :bass, :default => "0"
      t.string :drums, :default => "0"
      t.string :keyboards, :default => "0"
      t.integer :project_id
    end
  end
end
