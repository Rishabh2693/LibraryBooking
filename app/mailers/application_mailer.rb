class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  default from: "library.ncstate@gmail.com"
  def reservation_email(user, booking)
    @user = user
    @url = "http://www.google.com/"
    mail(to: 'rjain9@ncsu.edu', subject: 'NCSU Libraries room reservation')

  end
end

