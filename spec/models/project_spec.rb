require 'rails_helper'

RSpec.describe Project, type: :model do

  context "Instance Methods" do
    
    let(:project) { FactoryGirl.build(:project)}

    it "has a valid factory" do
      FactoryGirl.create(:project).should be_valid
    end

    it "has a name" do
      expect(project.name).to be_truthy
    end

    it "is invalid without a name" do
      expect(project.update(:name => nil)).to be(false)
    end

    it "has a description" do
      expect(project.update(:description => "Hoodie pork belly freegan typewriter cronut Shoreditch. Tilde VHS jean shorts, Echo Park banjo messenger bag bicycle rights gastropub Tumblr you probably haven't heard of them pop-up mustache.")).to be(true)
    end

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
