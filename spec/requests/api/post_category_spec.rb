require 'rails_helper'

RSpec.describe "Api::PostCategories", type: :request do
  describe "POST /create" do
		let(:post_category_params) do
			attributes_for(:post_category)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/post_category/create", params:{post_category: post_category_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			post_category_params = nil
			it "return http status bad_request" do
				post "/api/post_category/create", params:{post_category: post_category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/post_category/create", params:{post_category: post_category_params}
				post "/api/post_category/create", params:{post_category: post_category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
