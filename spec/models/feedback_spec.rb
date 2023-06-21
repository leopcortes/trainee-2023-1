require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:user) { create(:user, id:10, name:"aaa", email:"a@gmail.com", password:"123456", is_admin:true) }
  let(:post) { create(:post, user_id:user.id) }
  context "Testing factory" do
    it "should be valid" do
      expect(build(:feedback, post_id: post.id, user_id:user.id)).to be_valid
    end
  end

  context "Validating post" do
    it "should be invalid if nil" do
      expect(build(:feedback, post_id: nil)).to be_invalid
    end
    
    it "should be invalid if id does not exists" do
      expect(build(:feedback, post_id: -1)).to be_invalid
    end
  end
end
