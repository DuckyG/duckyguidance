require File.dirname(__FILE__) + "/spec_helper"

describe Counselor do
  it "should have roles after being created" do
    @school = Factory(:school)
    @counselor = FactoryGirl.create(:counselor, school: @school)

    @counselor.has_role?(:member, @school.subdomain).should == true
    @counselor.has_role?(:counselor, @school).should == true
  end
end
