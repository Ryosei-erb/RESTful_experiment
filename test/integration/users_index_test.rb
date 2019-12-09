require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:john)
    @non_admin = users(:denaris)
  end
  
  test "index as admin and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template "users/index"
    assert_select "a[href=?]",user_path(@non_admin)
    assert_difference "User.count",-1 do
      delete user_path(@non_admin)
    end
    assert_select "a[href=?]",user_path(@non_admin),count: 0
  end
  
  test "index as non admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select "a",text:"delete",count: 0
  end
end
