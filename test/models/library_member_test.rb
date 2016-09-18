require 'test_helper'

class LibraryMemberTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @librarymember = LibraryMember.new(name: "Example User", email: "user@example.com",
                    password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @librarymember.valid?
  end

  test "email should be present" do
    @librarymember.email = "     "
    assert_not @librarymember.valid?
  end

  test "name should not be too long" do
    @librarymember.name = "a" * 51
    assert_not @librarymember.valid?
  end

  test "email should not be too long" do
    @librarymember.email = "a" * 244 + "@example.com"
    assert_not @librarymember.valid?
  end
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @librarymember.email = valid_address
      assert @librarymember.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test "email addresses should be unique" do
    duplicate_user = @librarymember.dup
    @librarymember.save
    assert_not duplicate_user.valid?
    duplicate_user.email = @librarymember.email.upcase
  end
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @librarymember.email = mixed_case_email
    @librarymember.save
    assert_equal mixed_case_email.downcase, @librarymember.reload.email
  end

  test "password should be present (nonblank)" do
    @librarymember.password = @librarymember.password_confirmation = " " * 6
    assert_not @librarymember.valid?
  end

  test "password should have a minimum length" do
    @librarymember.password = @librarymember.password_confirmation = "a" * 5
    assert_not @librarymember.valid?
  end

end
