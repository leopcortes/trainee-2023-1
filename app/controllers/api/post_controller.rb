class Api::PostController < ApplicationController
    def create
        post = Post.new(post_params)
        post.save!
        render json: post, status: :created #201
    rescue StandardError => e
      render json: e, status: :bad_request 
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
