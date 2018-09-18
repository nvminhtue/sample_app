class UserMailer < ApplicationMailer
  default from: "minhtue.bot@gmail.com"
  def account_activation user
    @user = user
    mail to: @user.email, subject: t("mailers.user_mailer.act_subject")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("mailers.user_mailer.pass_subject")
  end
end
