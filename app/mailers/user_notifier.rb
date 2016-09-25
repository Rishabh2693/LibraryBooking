class UserNotifier < ActionMailer::Base
  default :from => 'bkasliwal@gmail.com'
  layout 'mailer'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def room_booking_email(library_member)
    @library_member = library_member
    temp = mail( :to => @library_member.email,
    :subject => 'Thanks for signing up for our amazing app' )
    a=1
  end
end