require 'rails_helper'

RSpec.describe "Api::Commentaries", type: :request do
    describe "POST /create" do
		let(:postagem) { create(:post) }
		let(:commentary_params) { 
			{
				content: "legal",
				post_id: postagem.id
			}
		}
		context 'params are ok' do
			it 'return https status created' do
				post "/api/commentaries/create", params:{commentary: commentary_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			it "return http status bad_request" do
				commentary_params = nil
				post "/api/commentaries/create", params:{commentary: commentary_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/commentaries/create", params: commentary_params
				post "/api/commentaries/create", params: commentary_params
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

    describe "GET /show/:id" do
		let(:commentary) {create(:commentary)}
		context "when id exist" do
			before do
				get "/api/commentaries/show/#{commentary.id}"
			end
			it "return http status ok" do
				expect(response).to have_http_status(:ok)
			end
		end
		context "when id not found" do
			before do
				get "/api/commentaries/show/-1"
			end
			it "return http status not_found" do
				expect(response).to have_http_status(:not_found)
			end
		end
	end

    describe "PATCH /update/:id" do
		let(:commentary) { create(:commentary, content:"legal") }
		let(:commentaries_params) do
		  	attributes_for(:commentary)
		end
		context "when params are ok" do
			it "return http status ok" do
				patch "/api/commentaries/update/#{commentary.id}", params:{commentary: commentaries_params }
				expect(response).to have_http_status(:ok)
			end
		end
	end
end
