class Api::PostsController < ApplicationController
    def create
        post = Post.new(post_params)
        post.save!
        render json: post, status: :created #201
    rescue StandardError => e
        render json: e, status: :bad_request 
    end

    def index
        post = Post.all
        render json: post, :except => [:created_at, :updated_at], status: :ok
    end

    def show
        post = Post.find(params[:id])
        render json: post, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def update 
        post = Post.find(params[:id])
        post.update!(post_params)
        render json: post, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found #404 ou :bad_request #400
    end

    def delete
        post = Post.find(params[:id])
        post.destroy!
        render json: post, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request 
    end

    private

    def post_params
        params.require(:post).permit(:title, :content)
    end
end
