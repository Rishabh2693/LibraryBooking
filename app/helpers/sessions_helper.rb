module SessionsHelper

  # Logs in the given user.
  def log_in(library_member)
    session[:library_member_id] = library_member.id
  end
  def current_user
    @current_user ||= LibraryMember.find_by(id: session[:library_member_id])
  end
  def logged_in?
    !current_user.nil?
  end
  def log_out
    session.delete(:library_member_id)
    @current_user = nil
  end

  def current_user?(library_member)
    library_member == current_user
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end