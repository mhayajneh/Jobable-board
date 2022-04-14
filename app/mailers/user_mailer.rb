# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'mohammad.alhayajneh98@gmail.com'
  def seen_application(user)
    mail(to: user, subject: 'Your Application is received')
  end
end
