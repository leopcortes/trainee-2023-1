require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  describe "POST /create" do
		let(:post_params) do
			attributes_for(:post)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/posts/create", params:{post: post_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			post_params = nil
			it "return http status bad_request" do
				post "/api/posts/create", params:{post: post_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/posts/create", params:{post: post_params}
				post "/api/posts/create", params:{post: post_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

  describe "GET /show/:id" do
    let(:post) {create(:post)}
    context "when id exist" do
      before do
        get "/api/posts/show/#{post.id}"
      end
      it "return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
    context "when id not found" do
      before do
        get "/api/posts/show/-1"
      end
      it "return http status not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
