require 'rails_helper'

RSpec.describe User, type: :model do
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

  it "has many projects" do 
    p = User.reflect_on_association(:projects)
    p.macro.should == :has_many
  end

  it "has many tracks" do 
    p = User.reflect_on_association(:tracks)
    p.macro.should == :has_many
  end

  it "has many comments" do 
    p = User.reflect_on_association(:comments)
    p.macro.should == :has_many
  end
end
