class Api::DevUrlsController < ApplicationController
    
    def create
        @url = DevUrl.new(original: params[:original_url])
        if @url.save
          render json: { short_url: short_url(@url.short_url) }, status: :created
        else
          render json: { error: @url.errors.full_messages }, status: :unprocessable_entity
        end
      end
end
