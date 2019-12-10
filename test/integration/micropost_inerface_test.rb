require 'test_helper'

class MicropostInerfaceTest < ActionDispatch::IntegrationTest
 def setup 
   @user = users(:john)
 end
 
 test "micropost interface" do
  log_in_as(@user)
  get root_url
  #失敗する投稿をテスト
  assert_no_difference "Micropost.count" do
   post microposts_path, params: { micropost: { content: " "}}
  end
  #成功する投稿をテスト
  
  assert_difference "Micropost.count" do
   post microposts_path, params: {micropost: {content: "PDCA"}}
  end
  assert_redirected_to root_url
  follow_redirect!
  
  #投稿を削除するテスト
  #micropost = microposts(:red)
  #assert_difference "Micropost.count" do
  # delete micropost_path(micropost)
  #end
  #違うユーザーのページでリンクがないことをテスト
  get user_path(users(:denaris))
  assert_select "a",text:"delete",count:0
 end
end
