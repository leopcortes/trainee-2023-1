class Api::FeedbackController < ApplicationController
    def create
        feedback = Feedback.new(feedback_params)
        feedback.save!
        render json: feedback, status: :created #201
    rescue StandardError => e
        render json: e, status: :bad_request 
    end
    
    private
    
    def feedback_params
        params.require(:feedback).permit(:like, :post_id)
    end
end
