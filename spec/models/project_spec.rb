require 'rails_helper'

RSpec.describe Project, type: :model do
  context "Instance Methods" do
    
  end

  context "Associations" do
    it "belongs to user" do
      p = Project.reflect_on_association(:user)
      # p.macro.should == :belongs_to
      expect(p.macro).to eq(:belongs_to)
    end
  end
end
