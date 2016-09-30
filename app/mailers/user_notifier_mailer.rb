class UserNotifierMailer < ApplicationMailer
  layout 'mailer'
  default from: "library.ncstate@gmail.com"
  def send_signup_email(user_emails, booking)
    @url = "http://www.google.com/"
    @booking = booking
    mail(to: user_emails, subject: 'NCSU Libraries room reservation')

  end
end
