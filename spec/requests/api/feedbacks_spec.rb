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
				post "/api/feedbacks/create", params:{feedback: feedback_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			it "return http status bad_request" do
				feedback_params = nil
				post "/api/feedbacks/create", params:{feedback: feedback_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/feedbacks/create", params: feedback_params
				post "/api/feedbacks/create", params: feedback_params
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

	describe "GET /show/:id" do
		let(:feedback) {create(:feedback)}
		context "when id exist" do
			before do
				get "/api/feedbacks/show/#{feedback.id}"
			end
			it "return http status ok" do
				expect(response).to have_http_status(:ok)
			end
		end
		context "when id not found" do
			before do
				get "/api/feedbacks/show/-1"
			end
			it "return http status not_found" do
				expect(response).to have_http_status(:not_found)
			end
		end
	end

	describe "PATCH /update/:id" do
		let(:feedback) { create(:feedback, like:false) }
		let(:feedback_params) do
		  	attributes_for(:feedback)
		end
		context "when params are ok" do
			it "return http status ok" do
				patch "/api/feedbacks/update/#{feedback.id}", params:{feedback: feedback_params }
				expect(response).to have_http_status(:ok)
			end
		end
	end

	describe " DELETE /delete/:id" do
		let(:feedback) {create(:feedback)}
		context 'feedback exist' do
			it 'return https status ok' do
				delete "/api/feedbacks/delete/#{feedback.id}"
				expect(response).to have_http_status(:ok)
			end
		end
		context 'feedback does not exist' do
			it 'return https status bad_request' do
				delete "/api/feedbacks/delete/-1"
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
