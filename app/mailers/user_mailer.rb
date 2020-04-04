class UserMailer < ApplicationMailer
  add_template_helper ApplicationHelper

  def send_email user, email, carts, total
    @user = user
    @carts = carts
    @total = total
    mail(to: email, subject: "Your order")
  end
end
