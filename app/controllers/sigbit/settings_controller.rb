module Sigbit
  class SettingsController < Sigbit::ApplicationController
    before_action :get_setting, only: [:edit, :update]

    def index
      @settings = Sigbit::Setting.get_all
    end

    def edit
    end

    def update
      if @setting.value != params[:setting][:value]
        @setting.value = params[:setting][:value]
        @setting.save
        redirect_to settings_path, notice: "Setting has updated."
      else
        redirect_to settings_path
      end
    end

    def get_setting
      @setting = Sigbit::Setting.find_by(var: params[:id]) || Sigbit::Setting.new(var: params[:id])
    end
  end
end
