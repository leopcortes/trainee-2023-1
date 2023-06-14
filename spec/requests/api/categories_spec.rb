require 'rails_helper'

RSpec.describe "Api::Categories", type: :request do
    describe "POST /create" do
		let(:category_params) do
			attributes_for(:category)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/categories/create", params:{category: category_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			category_params = nil
			it "return http status bad_request" do
				post "/api/categories/create", params:{category: category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/categories/create", params:{category: category_params}
				post "/api/categories/create", params:{category: category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
