require 'spec_helper'

describe "Follow/Unfollow" do
  
  before(:each) do
    @user_1 = Factory(:user)
    @user_2 = Factory(:user, :name => "Mr Follow", :email => Factory.next(:email))
    integration_sign_in(@user_1)
  end

  describe "following" do
    
    it "should follow a user" do
      lambda do
        visit users_path
        click_link "Mr Follow"
        response.should have_selector("input", :value => "Follow")
        click_button
      end.should change(Relationship, :count).by(1)
    end
    
  end
  
  describe "unfollowing" do
    
    before(:each) do
      @user_1.follow!(@user_2)
    end
    
    it "should unfollow a user" do
      lambda do
        visit users_path
        click_link "Mr Follow"
        response.should have_selector("input", :value => "Unfollow")
        click_button
      end.should change(Relationship, :count).by(-1)
    end
    
  end
      
end