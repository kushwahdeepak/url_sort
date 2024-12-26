class Api::DevUrlsController < ApplicationController
    skip_before_action :verify_authenticity_token  # Skip CSRF protection for API

    before_action :authenticate

    API_TOKEN = ENV['API_TOKEN'] || "c916f711343c8ec98e0d210fb41f6e6b46"
    def create
        @url = DevUrl.new(original_url: params[:original_url])
        if @url.save
          render json: { short_url: short_url(@url.short_url) }, status: :created
        else
          render json: { error: @url.errors.full_messages }, status: :unprocessable_entity
        end
    end

      private

    def authenticate
      token = request.headers['Authorization']
      head :unauthorized unless token == API_TOKEN
    end

end
