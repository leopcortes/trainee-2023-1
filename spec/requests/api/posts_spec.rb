require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  describe "POST /create" do
		let(:post_params) do
			attributes_for(:post)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/posts/create", params:{post: post_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			post_params = nil
			it "return http status bad_request" do
				post "/api/posts/create", params:{post: post_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/posts/create", params:{post: post_params}
				post "/api/posts/create", params:{post: post_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

  describe "GET /index" do
    before do 
      create(:post, id: 1, title: "Postagem1", content: "aaaaa")
      create(:post, id: 2, title: "Postagem2", content: "bbbbb")
      create(:post, id: 3, title: "Postagem3", content: "ccccc")
    end
    context 'when index return' do
      before do
        get '/api/posts/index'
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
          'title' => "Postagem1",
          'content' => "aaaaa"
        },
        {
          'id' => 2,
          'title' => "Postagem2",
          'content' => "bbbbb"
        },
        {
          'id' => 3,
          'title' => "Postagem3",
          'content' => "ccccc"
        }
        ])
      end
    end
  end

  describe "GET /show/:id" do
    let(:post) {create(:post)}
    context "when id exist" do
      before do
        get "/api/posts/show/#{post.id}"
      end
      it "return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
    context "when id not found" do
      before do
        get "/api/posts/show/-1"
      end
      it "return http status not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /update/:id" do
    let(:post) { create(:post, title:'Tutorial subir de elo no lol') }
    let(:post_params) do
      attributes_for(:post)
    end
    context "when params are ok" do
      it "return http status created" do
        patch "/api/posts/update/#{post.id}", params:{post: post_params}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe " DELETE /delete/:id" do
    let(:post) {create(:post)}
    context 'post exist' do
      it 'return https status ok' do
        delete "/api/posts/delete/#{post.id}"
        expect(response).to have_http_status(:ok)
      end
    end
    context 'post does not exist' do
      it 'return https status bad_request' do
        delete "/api/posts/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
