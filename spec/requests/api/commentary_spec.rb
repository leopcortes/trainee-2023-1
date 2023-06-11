require 'rails_helper'

RSpec.describe "Api::Commentaries", type: :request do
  describe "POST /create" do
		let(:commentary_params) do
			attributes_for(:commentary)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/commentary/create", params:{commentary: commentary_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			commentary_params = nil
			it "return http status bad_request" do
				post "/api/commentary/create", params:{commentary: commentary_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/commentary/create", params:{commentary: commentary_params}
				post "/api/commentary/create", params:{commentary: commentary_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
