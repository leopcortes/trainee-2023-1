require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:post) { create(:post) }
  context "Testing factory" do
    it "should be valid" do
      expect(build(:feedback, post_id: post.id)).to be_valid
    end
  end

  context "Testing post" do
    it "should be invalid if nil" do
      expect(build(:feedback, post_id: nil)).to be_invalid
    end
    
    it "should be invalid if id does not exists" do
      expect(build(:feedback, post_id: -1)).to be_invalid
    end
  end
end
