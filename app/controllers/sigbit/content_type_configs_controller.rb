module Sigbit
  class ContentTypeConfigsController < Sigbit::ApplicationController
    before_action :disable_page_tree

    def show
      @config = Sigbit::ContentTypeConfig.first_or_create
      respond_to do |format|
        format.html {}
        format.json { render json: @config.data }
      end
    end

    def update
      @config = Sigbit::ContentTypeConfig.first
      @config.data = secure_params[:data]
      if @config.save
        redirect_to content_type_config_path
       else
         render :show
       end
    end

    private

      def disable_page_tree
        @body_class = "with-sidebar"
      end

      def secure_params
        params.permit!
      end
  end
end
