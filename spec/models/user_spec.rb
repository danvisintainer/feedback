require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) {@user = User.new(:name => "Alex", :primary_instrument => "Drums")}

  it "has a name" do
   expect(@user.name).to eq("Alex")
  end

  it "has a primary instrument" do
   expect(@user.primary_instrument).to be_truthy
  end

  it "can't be created without a name" do
    expect {User.new(:name => nil)}.to raise_error
  end

  it "can have projects" do 
    p = User.reflect_on_association(:projects)
    p.macro.should == :has_many
  end
end
