class DevUrlsController < ApplicationController
    def new
        @url = DevUrl.new
      end
    
      def create
        @url = DevUrl.new(url_params)
        if @url.save
          redirect_to @url
        else
          render :new
        end
      end
    
      def show
        @url = DevUrl.find(params[:id])
      end
    
      def redirect
        url = DevUrl.find_by(short_url: params[:short_url])
        if url
          redirect_to url.original, allow_other_host: true
        else
          render plain: "URL not found", status: :not_found
        end
      end
    
      private
    
      def url_params
        params.require(:dev_url).permit(:original_url)
      end
end
