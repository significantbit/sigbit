module Sigbit
  module Nodes
    class PublishesController < Sigbit::ApplicationController
      before_action :get_node
      skip_before_action :verify_authenticity_token

      def update
          if @node.published?
            @node.unpublish!
            @node.descendants.each(&:unpublish!)
          else
            @node.publish!
            @node.descendants.each(&:publish!)
          end
      end

      private
      def get_node
        @node = Node.find params[:node_id]
      end
    end
  end
end

