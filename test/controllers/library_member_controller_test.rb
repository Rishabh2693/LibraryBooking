require 'test_helper'

class LibraryMemberControllerTest < ActionDispatch::IntegrationTest

  def setup
    @library_member = library_members(:michael)
    @other_library_member = library_members(:archer)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get library_members_path
    assert_redirected_to login_url
  end


  test "should redirect destroy when not logged in" do
    assert_no_difference 'LibraryMember.count' do
      delete library_member_path(@library_member)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_library_member)
    assert_no_difference 'LibraryMember.count' do
      delete library_member_path(@library_member)
    end
    assert_redirected_to root_url
  end
end
