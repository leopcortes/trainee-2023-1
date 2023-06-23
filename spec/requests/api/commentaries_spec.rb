require 'rails_helper'

RSpec.describe "Api::Commentaries", type: :request do
	let(:user) { create(:user) }
	let(:authentication_params) {{
		'X-User-Email': user.email,
		'X-User-Token': user.authentication_token
	}}
	let(:user_admin) { create(:user, is_admin:true) }
	let(:admin_authentication_params) {{
		'X-User-Email': user_admin.email,
		'X-User-Token': user_admin.authentication_token
	}}
		
    describe "POST /create" do
		before do
			create(:user, id:1, name:"aaa", email:"aaa@gmail.com", password:"123456", is_admin: true)
			create(:post, id:1, title:"aaa", content:"aaaaa", user_id:1)
		end
		let(:commentary_params) { 
			{
				content: "legal",
				post_id: 1,
				user_id: 1
			}
		}
		context 'params are ok' do
			it 'return https status created' do
				post "/api/commentaries/create", params:{commentary: commentary_params}, headers: admin_authentication_params
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			it "return http status bad_request" do
				commentary_params = nil
				post "/api/commentaries/create", params:{commentary: commentary_params}, headers: admin_authentication_params
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/commentaries/create", params: commentary_params, headers: admin_authentication_params
				post "/api/commentaries/create", params: commentary_params, headers: admin_authentication_params
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

    describe "GET /index" do
		before do 
			create(:user, id: 100, name: "ana", email: "ana@gmail.com", password: "123456", is_admin: true)
			create(:post, id: 1, user_id:100, title: "Postagem1", content: "aaaaa")
			create(:post, id: 2, user_id:100, title: "Postagem2", content: "bbbbb")
			create(:post, id: 3, user_id:100, title: "Postagem3", content: "ccccc")
			create(:commentary, id: 1, user_id:100, content:"legal", post_id:1)
			create(:commentary, id: 2, user_id:100, content:"maneiro", post_id:2)
			create(:commentary, id: 3, user_id:100, content:"massa", post_id:3)
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
				'post' => {
					"id" => 1,
					"title" => "Postagem1",
					"content" => "aaaaa"
				},
				'user' => {
					"email" => "ana@gmail.com"
				}
				},
				{
				'id' => 2,
				'content' => "maneiro",
				'post' => {
					"id" => 2,
					"title" => "Postagem2",
					"content" => "bbbbb"
				},
				'user' => {
					"email" => "ana@gmail.com"
				}
				},
				{
				'id' => 3,
				'content' => "massa",
				'post' => {
					"id" => 3,
					"title" => "Postagem3",
					"content" => "ccccc"
				},
				'user' => {
					"email" => "ana@gmail.com"
				}
				}
				])
			end
		end
	end

    describe "GET /show/:id" do
		let(:user) {create(:user, id:200, email:"ddd@gmail.com", is_admin:true)}
		let(:post) {create(:post, id:200, user_id:200)}
		let(:commentary) {create(:commentary, user_id:user.id, post_id:post.id)}
		let(:commentary_params) do
			attributes_for(:commentary)
		end
		context "when id exist" do
			before do
				get "/api/commentaries/show/#{commentary.id}", params: {commentary: commentary_params}, headers: authentication_params
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
		let(:user) {create(:user, id:200, email:"ddd@gmail.com", is_admin:true)}
		let(:post) {create(:post, id:200, user_id:200)}
		let(:commentary) {create(:commentary, user_id:user.id, post_id:post.id, content:"legal")}
		let(:commentaries_params) do
		  	attributes_for(:commentary)
		end
		context "when params are ok" do
			it "return http status ok" do
				patch "/api/commentaries/update/#{commentary.id}", params:{commentary: commentaries_params }, headers: admin_authentication_params
				expect(response).to have_http_status(:ok)
			end
		end
	end

    describe "DELETE /delete/:id" do
		let(:user) {create(:user, id:300, email:"eee@gmail.com", is_admin:true)}
		let(:post) {create(:post, id:300, user_id:300)}
		let(:commentary) {create(:commentary, user_id:user.id, post_id:post.id)}

		context 'commentary exist' do
			it 'return https status ok' do
				delete "/api/commentaries/delete/#{commentary.id}", headers: admin_authentication_params
				expect(response).to have_http_status(:ok)
			end
		end
		context 'commentary does not exist' do
			it 'return https status bad_request' do
				delete "/api/commentaries/delete/-1", headers: admin_authentication_params
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
end
