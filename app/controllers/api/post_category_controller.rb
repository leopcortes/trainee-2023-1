class Api::PostCategoryController < ApplicationController
    def create
        post_category = Post_category.new(post_category_params)
        post_category.save!
        render json: post_category, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end

    private

    def post_category_params
        params.require(:post_category).permit(:post_id, :category_id)
    end
end
