#encoding: utf-8
require 'user'

describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
  
  it "不该属于没有分配给他的角色" do
    user = User.new
    user.should_not be_in_role("unassigned role")
  end
end
