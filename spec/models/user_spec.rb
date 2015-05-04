require 'rails_helper'

RSpec.describe User, type: :model do

  context "Class Methods" do 
    it "returns an array of instruments" do
      instruments = User.instruments
      expect(instruments.length).to eq(7)
      expect(instruments[0]).to eq("Guitar")
    end
  end

  context "Instance Methods" do

    let(:user) { FactoryGirl.build(:user)}

    it "has a valid factory" do
      FactoryGirl.create(:user).should be_valid
    end

    it "can have a primary instrument" do
      user.primary_instrument = "Drums"
      expect(user.save).to eq(true)
    end

    it "can be saved without a primary instrument" do
      user.primary_instrument = nil
      expect(user.save).to eq(true)
    end

    it "is valid with only a name and password" do
      expect(user.update(:name => "Someone", :password => "something")).to eq(true)
    end

    it "is invalid without a name or twitter_username" do
      expect(user.update(:name => nil, :twitter_username => nil)).to eq(false)
    end

    it "is valid with only a twitter_username" do
      expect(user.update(:twitter_username => "test")).to eq(true)
    end

    it "has an avatar" do
      expect(user.avatar_url).to be_truthy
    end

    it "is invalid without an avatar" do
      expect(user.update(:avatar_url => nil)).to eq(false)
    end

    it "returns the musician type based on the primary instrument" do
      user.primary_instrument = User.instruments[0]
      expect(user.musician_type).to eq("Guitarist")
      user.primary_instrument = User.instruments[1]
      expect(user.musician_type).to eq("Bassist")
      user.primary_instrument = User.instruments[2]
      expect(user.musician_type).to eq("Drummer")
      user.primary_instrument = User.instruments[3]
      expect(user.musician_type).to eq("Keyboardist")
      user.primary_instrument = User.instruments[4]
      expect(user.musician_type).to eq("Saxophonist")
      user.primary_instrument = User.instruments[5]
      expect(user.musician_type).to eq("Vocalist")
      user.primary_instrument = User.instruments[6]
      expect(user.musician_type).to eq("Musician")
    end
  end


  context "Associations" do
    it "has many comments" do 
      p = User.reflect_on_association(:comments)
      expect(p.macro).to eq(:has_many)
    end
    
      it "has many projects" do 
      p = User.reflect_on_association(:projects)
      expect(p.macro).to eq(:has_many)
    end

    it "has many tracks" do 
      p = User.reflect_on_association(:tracks)
      expect(p.macro).to eq(:has_many)
    end
  end

end
