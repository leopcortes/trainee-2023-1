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
end
