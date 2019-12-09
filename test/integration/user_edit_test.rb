require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
 def setup
   @user = users(:john)
 end
 
 test "unsuccessful edit" do 
   log_in_as(@user)
   get edit_user_path(@user)
   assert_template "users/edit"
   patch user_path(@user), params: { user: {name: "",
                                            email: "",
                                            password: "",
                                            password_confirmation:""}}
   assert_template "users/edit"
 end
 
 test "successful edit" do
   log_in_as(@user)
   get edit_user_path(@user)
   assert_template "users/edit"
   name = "John Snow"
   email = "John@snow.com"
   patch user_path(@user), params: { user: {name: name,
                                            email: email,
                                            password: "",
                                            password_confirmation:""}}
   assert_redirected_to @user
   @user.reload
   assert_equal name, @user.name
   assert_equal email,@user.email
 end
end
