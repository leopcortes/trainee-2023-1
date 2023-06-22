class Api::PostCategoriesController < ApplicationController
    def create
        post_category = PostCategory.new(post_category_params)
        post_category.save!
        render json: post_category, status: :created
    rescue StandardError => e
        render e, status: :bad_request 
    end

    def index
        post_category = PostCategory.all
        render json: post_category, :except => [:created_at, :updated_at], status: :ok
    end

    def show
        post_category = PostCategory.find(params[:id])
        render json: post_category, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def update 
        post_category = PostCategory.find(params[:id])
        post_category.update!(post_category_params)
        render json: post_category, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found #404 ou :bad_request #400
    end

    def delete
        post_category = PostCategory.find(params[:id])
        post_category.destroy!
        render json: post_category, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request 
    end

    private

    def post_category_params
        params.require(:post_category).permit(:post_id, :category_id)
    end
end
