class Api::FeedbacksController < ApplicationController
    def create
        feedback = Feedback.new(feedback_params)
        feedback.save!
        render json: feedback, status: :created
    rescue StandardError
        head(:bad_request)
    end
    
    private

    def feedback_params
        params.require(:feedback).permit(:like, :post_id)
    end
end
