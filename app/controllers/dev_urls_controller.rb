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
    
      private
    
      def url_params
        params.require(:dev_url).permit(:original_url)
      end
end
