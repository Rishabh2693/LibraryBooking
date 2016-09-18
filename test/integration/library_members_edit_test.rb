require 'test_helper'

class LibraryMembersEditTest < ActionDispatch::IntegrationTest
  def setup
    @library_member = library_members(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@library_member)
    get edit_library_member_path(@library_member)
    assert_template 'library_members/edit'
    patch library_member_path(@library_member), params: { library_member: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }

    assert_template 'library_members/edit'
  end

end
