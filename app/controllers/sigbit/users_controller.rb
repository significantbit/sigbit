module Sigbit
  class UsersController < Sigbit::ApplicationController
    def index
      @users = Sigbit::User.all
    end

    def new
      @user = Sigbit::User.new
      render "_form"
    end

    def create
      @user = Sigbit::User.new secure_params
      if @user.save
        redirect_to users_path, success: t(".success")
      else
        render :new
      end
    end

    def edit
      @user = Sigbit::User.find params[:id]
      render "_form"
    end

    def update
      @user = Sigbit::User.find params[:id]
      if @user.update secure_params
        redirect_to users_path, success: t(".success")
      else
        render :new
      end
    end

    def destroy
      @user = Sigbit::User.find params[:id]
      @user.destroy
      redirect_to users_path, success: t(".success")
    end

    private

      def secure_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end
  end
end
