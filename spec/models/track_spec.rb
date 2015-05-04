require 'rails_helper'

RSpec.describe Track, type: :model do
  
  context "Class Methods" do
    it "converts a time object to a string of an integer" do
      expect(Track.current_time.is_a?(String)).to eq(true)
    end

    it "trims a wav file"
    it "converts to an MP3"
    
  end

  context "Instance Methods" do
    let(:track) {Track.new(:name => "A new track")}
    it "has a name" do
      expect(track.name).to be_instance_of(String)
    end

    it "has a description" do
      track.description = " Crucifix put a bird on it vinyl Austin cray stumptown fashion axe, Etsy Wes Anderson salvia plaid viral."
      expect(track.description).to be_instance_of(String)
    end

    it "has an attached audio file" do
      should have_attached_file(:audio)
    end

    it "is invalid without an attached audio file" do
      should validate_attachment_presence(:audio)
    end

  end

  context "Associations" do
    it "belongs to a project" do
      t = Track.reflect_on_association(:project)
      expect(t.macro).to eq(:belongs_to)
      
    end
    it "belongs to a user" do
      t = Track.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
