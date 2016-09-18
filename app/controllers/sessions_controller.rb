class SessionsController < ApplicationController
  def new
  end
  def create
    library_member = LibraryMember.find_by(email: params[:session][:email].downcase)
    if library_member && library_member.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in library_member
      redirect_back_or library_member
    else
      flash.now[:danger] = 'Invalid email/password combination'
      # Create an error message.
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
