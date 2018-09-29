module Sigbit
  class UsersController < Sigbit::ApplicationController
    def index
      @users = Sigbit::User.all
      authorize Sigbit::User
    end

    def new
      @user = Sigbit::User.new
      authorize @user
      render "_form"
    end

    def create
      @user = Sigbit::User.new secure_params
      authorize @user
      if @user.save
        redirect_to users_path, notice: t(".success")
      else
        render "_form"
      end
    end

    def edit
      @user = Sigbit::User.find params[:id]
      authorize @user
      render "_form"
    end

    def update
      @user = Sigbit::User.find params[:id]
      authorize @user
      if @user.update secure_params
        redirect_to edit_user_path(@user), notice: t(".success")
      else
        render "_form"
      end
    end

    def destroy
      @user = Sigbit::User.find params[:id]
      authorize @user
      @user.destroy
      redirect_to users_path, notice: t(".success")
    end

    private

      def secure_params
        params.require(:user).permit(:email, :image, :password, :password_confirmation)
      end
  end
end
