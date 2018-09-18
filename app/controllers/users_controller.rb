class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :defined_user, only: [:show, :destroy, :edit, :update]

  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page]
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t("controllers.users_controller.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t("controllers.users_controller.profile")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("controllers.users_controller.delete")
      redirect_to users_path
    else
      flash[:danger] = t("controllers.users_controller.danger")
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t("controllers.users_controller.please")
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) && flash[:danger] =
    t("controllers.users_controller.wrong") unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def defined_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t("controllers.users_controller.info")
    redirect_to root_path
  end
end
