require 'rails_helper'

RSpec.describe Project, type: :model do
  context "Instance Methods" do
    
  end

  context "Associations" do
    it "belongs to user" do
      p = Project.reflect_on_association(:user)
      expect(p.macro).to eq(:belongs_to)
    end

    it "has many tracks" do
      p = Project.reflect_on_association(:tracks)
      expect(p.macro).to eq(:has_many)
    end

    it "has a dependent destroy relationship with tracks" do
      p = Project.reflect_on_association(:tracks)
      expect(p.options[:dependent]).to eq(:destroy)
    end

    it "has many comments" do
      p = Project.reflect_on_association(:comments)
      expect(p.macro).to eq(:has_many)
    end

    it "has a dependent destroy relationship with comments" do
      p = Project.reflect_on_association(:comments)
      expect(p.options[:dependent]).to eq(:destroy)
    end

    it "has one instrument_need" do
      p = Project.reflect_on_association(:instrument_need)
      expect(p.macro).to eq(:has_one)
    end

    it "has a dependent destroy relationship with instrument_need" do
      p = Project.reflect_on_association(:instrument_need)
      expect(p.options[:dependent]).to eq(:destroy)
    end

  end
end
