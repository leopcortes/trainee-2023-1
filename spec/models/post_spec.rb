require 'rails_helper'

RSpec.describe Post, type: :model do
  context "Testing factory" do
    it "should be valid" do
      expect(build(:post)).to be_valid
    end
  end

  context "Validating title" do
    it "should be invalid if title nil" do
      expect(build(:post, title:nil)).to be_invalid
      expect(build(:post, title:'')).to be_invalid
    end

    it "should be invalid if title is repeated" do
      create(:post, title:'Piada do nao nem eu')
      expect(build(:post, title:'Piada do nao nem eu')).to be_invalid
    end
  end

  context "Validating content" do
    it "should be invalid if content nil" do
      expect(build(:post, content:nil)).to be_invalid
    end
  end
end
