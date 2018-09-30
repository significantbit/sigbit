module Sigbit
  class ApplicationController < ActionController::Base
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    helper RRT::Engine.helpers
    helper Attachinary::Engine.helpers
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :set_locale
    before_action :set_nodes_tree
    before_action :set_current_attributes
    after_action :verify_authorized

    layout "layouts/sigbit/sidenav"

    def default_url_options
      { locale: I18n.locale }
    end

    private

      def user_not_authorized
        flash[:alert] = t("sigbit.common.not_authorized")
        redirect_to(request.referrer || sigbit.root_path)
      end

      def set_locale
        @body_class = "with-sidebar show-sidebar"
        I18n.locale = params[:locale] || I18n.default_locale
      end

      def set_nodes_tree
        @dropdown = ancestry_options(
          Node
            .visible
            .arrange(order: "position")
          ) do |i|
              "#{'...' * i.depth} #{i.menu_title}"
            end
        #dropdown.unshift(["- Ingen förälder -", nil])
      end


      def ancestry_options(items, &block)
        return ancestry_options(items) { |i| "#{'...' * i.depth} #{i.menu_title}" } unless block_given?

        result = []
        items.map do |item, sub_items|
          result << [yield(item), item.id]
          #this is a recursive call:
          result += ancestry_options(sub_items, &block)
        end
        result
      end

      def set_current_attributes
        Sigbit::Current.user = current_user
        Sigbit::Current.request = request
      end
  end
end
