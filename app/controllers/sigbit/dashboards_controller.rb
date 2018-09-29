module Sigbit
  class DashboardsController < Sigbit::ApplicationController
    def show
      authorize "Sigbit::Dashboard".to_sym, :show?
    end
  end
end
