class Api::CommentariesController < ApplicationController
    def create
        commentary = Commentary.new(commentary_params)
        commentary.save!
        render json: commentary, status: :created
    rescue StandardError => e
        render e, status: :bad_request 
    end

    private

    def commentary_params
        params.require(:commentary).permit(:content, :post_id)
    end
end
