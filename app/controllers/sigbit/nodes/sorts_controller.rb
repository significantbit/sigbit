module Sigbit
  module Nodes
    class SortsController < ApplicationController
      before_action :get_node
      skip_before_action :verify_authenticity_token
      def update
        Node.acts_as_list_no_update do
          secure_params[:order].each do |node|
            Node.find(node[:id]).update(position: node[:position])
          end
        end
      end

      private
      def get_node
        @node = Node.find params[:node_id]
      end

      def secure_params
        params.permit(:node_id, :locale, order: [:id, :position])
      end
    end
  end
end
