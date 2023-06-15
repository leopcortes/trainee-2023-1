require 'rails_helper'

RSpec.describe "Api::Feedbacks", type: :request do
    describe "POST /create" do
		let(:postagem) { create(:post) }
		let(:feedback_params) { 
			{
				like: false,
				post_id: postagem.id
			}
		}
		context 'params are ok' do
			it 'return https status created' do
				p feedback_params
				post "/api/feedbacks/create", params:{feedback: feedback_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			feedback_params = nil
			it "return http status bad_request" do
				post "/api/feedbacks/create", params:{feedback: feedback_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/feedbacks/create", params:{feedback: feedback_params}
				post "/api/feedbacks/create", params:{feedback: feedback_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
