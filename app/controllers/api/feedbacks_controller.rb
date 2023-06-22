class Api::FeedbacksController < ApplicationController
    
    acts_as_token_authentication_handler_for User, only: [:create, :update, :delete]
    before_action :admin_authentication, only: [:create, :update, :delete]

    def create
        feedback = Feedback.new(feedback_params)
        feedback.save!
        render json: feedback, status: :created
    rescue StandardError => e
        render e, status: :bad_request 
    end

    def index
        feedback = Feedback.all
        render json: feedback, :except => [:created_at, :updated_at], status: :ok
    end

    def show
        feedback = Feedback.find(params[:id])
        render json: feedback, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end

    def update 
        feedback = Feedback.find(params[:id])
        feedback.update!(feedback_params)
        render json: feedback, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found #404 ou :bad_request #400
    end

    def delete
        feedback = Feedback.find(params[:id])
        feedback.destroy!
        render json: feedback, status: :ok
    rescue StandardError => e
        render json: e, status: :bad_request 
    end
    
    private

    def feedback_params
        params.require(:feedback).permit(:like, :post_id, :user_id)
    end
end
