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
end
