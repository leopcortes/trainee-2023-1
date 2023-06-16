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
end
