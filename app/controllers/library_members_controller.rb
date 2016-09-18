class LibraryMembersController < ApplicationController
  before_action :correct_library_member,   only: [:edit, :update]
  before_action :logged_in_library_member, only: [:index, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy
  def index
    @library_members = LibraryMember.all
  end
  def new
    @library_member = LibraryMember.new
  end
  def show
    @library_member = LibraryMember.find(params[:id])
  end

  def create
    @library_member = LibraryMember.new(library_member_params)
    if @library_member.save
      log_in @library_member
      flash[:success] = "Welcome to the NC State Library App!"
      redirect_to @library_member
    else
      render 'new'
    end
  end
  def edit
    @library_member = LibraryMember.find(params[:id])
  end

  def update
    @library_member = LibraryMember.find(params[:id])
    if @library_member.update_attributes(library_member_params)
      flash[:success] = "Profile updated"
      redirect_to @library_member
    else
      render 'edit'
    end
  end

  def destroy
    LibraryMember.find(params[:id]).destroy
    flash[:success] = "Library Member deleted"
    redirect_to library_members_url
  end




  private

  def library_member_params
    params.require(:library_member).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_library_member
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  def correct_library_member
    @library_member = LibraryMember.find(params[:id])
    redirect_to(root_url) unless current_user?(@library_member)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
