class SessionsController < ApplicationController

  def new
    redirect_to current_user if logged_in?
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == Settings.check.remember ? remember(@user) : forget(@user)
      redirect_back_or @user
    else
      flash.now[:danger] = t("controllers.sessions_controller.invalid")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
