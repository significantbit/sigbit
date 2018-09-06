module Sigbit
  class NodesController < Sigbit::ApplicationController

    def index
      #@nodes = SigbitNode.roots
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: Sigbit::Node.json_tree(Sigbit::Node.arrange(order: :position)) }
      end
    end

    def new
      @node = Sigbit::NewNodeForm.new parent_id: params[:parent_id]
      render "_new_form"
    end

    def create
      @node = Sigbit::NewNodeForm.new secure_params

      if @node.save
        redirect_to edit_node_path(@node.id)
      else
        render "_new_form"
      end
    end

    def edit
      @node = Sigbit::Node.find params[:id]
      render "_form"
    end

    def update
      @node = Sigbit::Node.find params[:id]
      if @node.update secure_params
        redirect_to edit_node_path(@node.id), success: t(".success")
      else
        render "_form"
      end
    end

    private

      def secure_params
        params.require(:node).permit!
      end
  end
end
