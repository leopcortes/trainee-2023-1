require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "POST /create" do
		let(:user_params) do
			attributes_for(:user)
		end
		context "when params are ok" do
			it "return http status created" do
				post "/api/users/create", params:{user: user_params}
				expect(response).to have_http_status(:created)
			end
		end
		context "when params are nil" do
			user_params = nil
			it "return http status bad_request" do
				post "/api/users/create", params:{user: user_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
		context "when params are repeated" do
			it "return http status bad_request" do
				post "/api/users/create", params:{user: user_params}
				post "/api/users/create", params:{user: user_params}
				expect(response).to have_http_status(:bad_request)
			end
		end
	end

  describe "GET /index" do
    before do
      create(:user, id:1, name:"Joao", email:"joao@gmail.com", is_admin:true)
      create(:user, id:2, name:"Maria", email:"maria@gmail.com", is_admin:true)
    end
    context 'when index return' do
      before do
        get '/api/users/index'
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
            'name' => "Joao",
            'email' => "joao@gmail.com",
            'is_admin' => true
        },
        {
            'id' => 2,
            'name' => "Maria",
            'email' => "maria@gmail.com",
            'is_admin' => true
        }
        ])
      end
    end
  end

  describe "GET /show/:id" do
    let(:user) {create(:user)}
    context "when id exist" do
        before do
            get "/api/users/show/#{user.id}"
        end
        it "return http status ok" do
            expect(response).to have_http_status(:ok)
        end
    end
    context "when id not found" do
        before do
            get "/api/users/show/-1"
        end
        it "return http status not_found" do
            expect(response).to have_http_status(:not_found)
        end
    end
  end

  describe "PATCH /update/:id" do
    let(:user) { create(:user, name:"Joao", email:"joao@gmail.com", is_admin:true) }
    let(:user_params) do
      attributes_for(:user)
    end
    context "when params are ok" do
        it "return http status created" do
            patch "/api/users/update/#{user.id}", params:{user: user_params}
            expect(response).to have_http_status(:ok)
        end
    end
  end

  describe "DELETE /delete/:id" do
    let(:user) {create(:user)}
    context 'user exist' do
        it 'return https status ok' do
            delete "/api/users/delete/#{user.id}"
            expect(response).to have_http_status(:ok)
        end
    end
    context 'user does not exist' do
        it 'return https status bad_request' do
            delete "/api/users/delete/-1"
            expect(response).to have_http_status(:bad_request)
        end
    end
  end
end
