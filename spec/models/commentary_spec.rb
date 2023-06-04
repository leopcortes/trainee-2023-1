require 'rails_helper'

RSpec.describe Commentary, type: :model do
  let(:post) { create(:post) }
  context "Testing factory" do
    it "should be valid" do
      expect(build(:commentary, post_id: post.id)).to be_valid
    end
  end

  context "Validating content" do
    it "should be invalid if content nil" do
      expect(build(:commentary, content:nil)).to be_invalid
    end
  end

  context "Testing post" do
    it "should be invalid if nil" do
      expect(build(:commentary, post_id: nil)).to be_invalid
    end
    
    it "should be invalid if id does not exists" do
      expect(build(:commentary, post_id: -1)).to be_invalid
    end
  end
end
