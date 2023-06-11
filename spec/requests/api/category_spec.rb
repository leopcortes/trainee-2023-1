require 'rails_helper'

RSpec.describe "Api::Categories", type: :request do
  describe "POST /create" do
		let(:category_params) do
			attributes_for(:category)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/category/create", params:{category: category_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			category_params = nil
			it "return http status bad_request" do
				post "/api/category/create", params:{category: category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/category/create", params:{category: category_params}
				post "/api/category/create", params:{category: category_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end
  
  describe "GET /show/:id" do
    let(:category) {create(:category)}
    context "when id exist" do
      before do
        get "/api/category/show/#{category.id}"
      end
      it "return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
    context "when id not found" do
      before do
        get "/api/category/show/-1"
      end
      it "return http status not_found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /update/:id" do
    let(:category) { create(:category, name:'Jogos') }
    let(:category_params) do
      attributes_for(:category)
    end
    context "when params are ok" do
      it "return http status created" do
        patch "/api/category/update/#{category.id}", params:{category: category_params}
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe " DELETE /delete/:id" do
    let(:category) {create(:category)}
    context 'category exist' do
      it 'return https status ok' do
        delete "/api/category/delete/#{category.id}"
        expect(response).to have_http_status(:ok)
      end
    end
    context 'category does not exist' do
      it 'return https status bad_request' do
        delete "/api/category/delete/-1"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
