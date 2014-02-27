require 'test_helper'

class Admin::UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "test_data_len" do
    user = Admin::User.all
    assert_equal 2,user.length
  end
  
  test "test_data_name_Taro" do
    user = Admin::User.find_by_name("Taro")[0]
    asssert_equal "Taro",user.title
  end
end
