require 'rails_helper'

RSpec.describe InstrumentNeed, type: :model do

  context "Instance Methods" do
    it "can have guitar, bass, drums, keyboard, vocals, saxophone or other needs" do
      instrument_need = InstrumentNeed.new
      expect(instrument_need.guitar).to be_truthy
      expect(instrument_need.bass).to be_truthy
      expect(instrument_need.drums).to be_truthy
      expect(instrument_need.keyboards).to be_truthy
      expect(instrument_need.vocals).to be_truthy
      expect(instrument_need.saxophone).to be_truthy
      expect(instrument_need.other).to be_truthy
    end
    
  end

  context "Associations" do
    it 'belongs to a project' do
    i = InstrumentNeed.reflect_on_association(:project)
    expect(i.macro).to eq(:belongs_to)
    end
  end
end
