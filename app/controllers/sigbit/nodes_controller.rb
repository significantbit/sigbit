module Sigbit
  class NodesController < Sigbit::ApplicationController
    def index
      #@nodes = SigbitNode.roots
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: Sigbit::Node.json_tree(Sigbit::Node.visible.arrange(order: :position)) }
      end
    end

    def new
      @node = Sigbit::NewNodeForm.new parent_id: params[:parent_id]
      if params[:parent_id].present?
        @parent = Sigbit::Node.find params[:parent_id]
      else
        @parent = Sigbit::Node.roots.first
      end
      render "_new_form"
    end

    def create
      @node = Sigbit::NewNodeForm.new secure_params

      if @node.save
        redirect_to edit_node_path(@node.id), notice: t(".success")
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
        redirect_to edit_node_path(@node.id), notice: t(".success")
      else
        render "_form"
      end
    end

    def destroy
      @node = Sigbit::Node.find params[:id]
      @node.destroy
      redirect_to root_path
    end

    private

      def secure_params
        params.require(:node).permit!
      end
  end
end
