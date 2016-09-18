require 'test_helper'

class LibraryMembersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'LibraryMember.count' do
      post library_members_path, params: { library_member: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'library_members/new'
    # assert is_logged_in?
  end
end
