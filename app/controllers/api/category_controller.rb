class Api::CategoryController < ApplicationController
    def create
        category = Category.new(category_params)
        category.save!
        render json: category, status: :created #201
    rescue StandardError => e
      render json: e, status: :bad_request 
    end
    
    def show
        category = Category.find(params[:id])
        render json: category, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def update 
        category = Category.find(params[:id])
        category.update!(category_params)
        render json: category, status: :ok
    rescue StandardError => e
      render json: e, status: :not_found #404 ou :bad_request #400
    end
    
    private
    
    def category_params
        params.require(:category).permit(:name, :description)
    end
end
