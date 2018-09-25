class PasswordResetsController < ApplicationController
  before_action :load_user, :valid_user, :check_expiration,
    only: [:edit, :update]

  def new; end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("controllers.password_resets_controller.info")
      redirect_to root_url
    else
      flash.now[:danger] = t("controllers.password_resets_controller.danger")
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add(:password, t("controllers.password_resets_controller.empty"))
      render :edit
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = t("controllers.password_resets_controller.success")
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def load_user
      @user = User.find_by(email: params[:email])
      return if @user
      flash[:danger] = t("controllers.users_controller.info")
      redirect_to root_path
    end

    def valid_user
      unless (@user&.activated? &&
        @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = t("controllers.password_resets_controller.expire")
        redirect_to new_password_reset_url
      end
    end
end
