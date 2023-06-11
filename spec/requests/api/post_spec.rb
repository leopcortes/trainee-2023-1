require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  describe "POST /create" do
		let(:post_params) do
			attributes_for(:post)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/post/create", params:{post: post_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			post_params = nil
			it "return http status bad_request" do
				post "/api/post/create", params:{post: post_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/post/create", params:{post: post_params}
				post "/api/post/create", params:{post: post_params}
				expect(response).to have_http_status(:bad_request)
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
        patch "/api/post/update/#{post.id}", params:{post: post_params}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe " DELETE /delete/:id" do
    let(:post) {create(:post)}
    context 'post exist' do
      it 'return https status ok' do
        delete "/api/post/delete/#{post.id}"
        expect(response).to have_http_status(:ok)
      end
    end
    context 'post does not exist' do
      it 'return https status bad_request' do
        delete "/api/post/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
