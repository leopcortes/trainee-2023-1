class Api::UsersController < ApplicationController
    def create
        user = User.new(user_params)
        user.save!
        render json: user, status: :created #201
    rescue StandardError => e
        render json: e, status: :bad_request 
    end

    def index
        user = User.all
        render json: user, :except => [:authentication_token, :created_at, :updated_at], status: :ok
    end

    def show
        user = User.find(params[:id])
        render json: user, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def update 
        user = User.find(params[:id])
        user.update!(user_params)
        render json: user, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found #404 ou :bad_request #400
    end

    def delete
        user = User.find(params[:id])
        user.destroy!
        render json: user, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request 
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :is_admin, :password)
    end
end
