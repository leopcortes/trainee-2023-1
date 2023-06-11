class Api::PostController < ApplicationController
    def create
        post = Post.new(post_params)
        post.save!
        render json: post, status: :created #201
    rescue StandardError => e
      render json: e, status: :bad_request 
    end

    def update 
        post = Post.find(params[:id])
        post.update!(post_params)
        render json: post, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found #404 ou :bad_request #400
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
