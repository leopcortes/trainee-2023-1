class Api::PostsController < ApplicationController
    def create
        post = Post.new(post_params)
        post.save!
        render json: post, status: :created #201
    rescue StandardError => e
      render json: e, status: :bad_request 
    end

    def show
        post = Post.find(params[:id])
        render json: post, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
