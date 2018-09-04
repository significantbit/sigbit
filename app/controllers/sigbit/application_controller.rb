module Sigbit
  class ApplicationController < ActionController::Base
    helper RRT::Engine.helpers
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :set_locale
    add_flash_types :success, :error
    layout "layouts/sigbit/sidenav"

    def default_url_options
      { locale: I18n.locale }
    end

    private

      def set_locale
        @body_class = "with-sidebar show-sidebar"
        I18n.locale = params[:locale] || I18n.default_locale
      end
  end
end
