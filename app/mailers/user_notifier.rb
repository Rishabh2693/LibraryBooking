class UserNotifier < ActionMailer::Base
  default :from => 'library.ncstate@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def room_booking_email(library_member)
    @library_member = library_member
    mail( :to => @library_member.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end