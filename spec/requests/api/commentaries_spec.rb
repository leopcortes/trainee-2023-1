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

    describe "GET /index" do
		before do 
			create(:post, id: 1, title: "Postagem1", content: "aaaaa")
			create(:post, id: 2, title: "Postagem2", content: "bbbbb")
			create(:post, id: 3, title: "Postagem3", content: "ccccc")
			create(:commentary, id: 1, content:"legal", post_id:1)
			create(:commentary, id: 2, content:"maneiro", post_id:2)
			create(:commentary, id: 3, content:"massa", post_id:3)
		end
		context 'when index return' do
			before do
				get '/api/commentaries/index'
			end
			it 'return http status ok' do
				expect(response).to have_http_status(:ok)
			end
			it 'return a json' do
				expect(response.content_type).to eq('application/json; charset=utf-8')
			end
			it 'return created instances' do
				expect(JSON.parse(response.body)).to eq([{
				'id' => 1,
				'content' => "legal",
				'post_id' => 1
				},
				{
				'id' => 2,
				'content' => "maneiro",
				'post_id' => 2
				},
				{
				'id' => 3,
				'content' => "massa",
				'post_id' => 3
				}
				])
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

    describe "DELETE /delete/:id" do
		let(:commentary) {create(:commentary)}
		context 'commentary exist' do
			it 'return https status ok' do
				delete "/api/commentaries/delete/#{commentary.id}"
				expect(response).to have_http_status(:ok)
			end
		end
		context 'commentary does not exist' do
			it 'return https status bad_request' do
				delete "/api/commentaries/delete/-1"
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
