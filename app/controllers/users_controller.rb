class UsersController < ApplicationController
  def show
    @user = User.find_by(id: params[:id])
    if @user == nil
      redirect_to signup_path
      flash[:info] = "User is not found. Make your own"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t("controllers.users_controller.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
    end
end
