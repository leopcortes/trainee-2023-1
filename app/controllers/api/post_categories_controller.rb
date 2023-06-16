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

    private

    def post_category_params
        params.require(:post_category).permit(:post_id, :category_id)
    end
end
