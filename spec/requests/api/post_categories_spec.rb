require 'rails_helper'

RSpec.describe "Api::PostCategories", type: :request do
    describe "POST /create" do
		let(:postagem) { create(:post) }
		let(:categoria) { create(:category) }
		let(:post_category_params) { 
			{
                post_id: postagem.id,
				category_id: categoria.id
			}
		}
		context 'params are ok' do
			it 'return https status created' do
				post "/api/post_categories/create", params:{post_category: post_category_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			it "return http status bad_request" do
				post_category_params = nil
				post "/api/post_categories/create", params:{post_category: post_category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/post_categories/create", params: post_category_params
				post "/api/post_categories/create", params: post_category_params
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

    describe "GET /index" do
		before do 
			create(:post, id: 1, title: "Postagem1", content: "aaaaa")
			create(:post, id: 2, title: "Postagem2", content: "bbbbb")
			create(:category, id: 1, name: "Categoria1", description: "zzzzz")
			create(:category, id: 2, name: "Categoria2", description: "xxxxx")
			create(:post_category, id: 1, post_id:1, category_id:1)
			create(:post_category, id: 2, post_id:2, category_id:2)
		end
		context 'when index return' do
			before do
				get '/api/post_categories/index'
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
				'post_id' => 1,
				'category_id' => 1
				},
				{
				'id' => 2,
				'post_id' => 2,
				'category_id' => 2
				}
				])
			end
		end
	end

    describe "GET /show/:id" do
		let(:post_category) {create(:post_category)}
		context "when id exist" do
			before do
				get "/api/post_categories/show/#{post_category.id}"
			end
			it "return http status ok" do
				expect(response).to have_http_status(:ok)
			end
		end
		context "when id not found" do
			before do
				get "/api/post_categories/show/-1"
			end
			it "return http status not_found" do
				expect(response).to have_http_status(:not_found)
			end
		end
	end

    describe "PATCH /update/:id" do
		let(:post_category) { create(:post_category) }
		let(:post_category_params) do
		  	attributes_for(:post_category)
		end
		context "when params are ok" do
			it "return http status ok" do
				patch "/api/post_categories/update/#{post_category.id}", params:{post_category: post_category_params }
				expect(response).to have_http_status(:ok)
			end
		end
	end
end
