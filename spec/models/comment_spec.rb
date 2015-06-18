require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "Associations" do
    it "belongs to a project" do
      c = Comment.reflect_on_association(:project)
      expect(c.macro).to eq(:belongs_to)
    end
    it "belongs to a user" do
      c = Comment.reflect_on_association(:user)
      expect(c.macro).to eq(:belongs_to)
    end
  end

end
