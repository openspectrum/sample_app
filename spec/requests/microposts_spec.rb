require 'spec_helper'

describe "Microposts" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,     :with => @user.email
    fill_in :password,  :with => @user.password
    click_button
  end
  
  describe "creation" do
    
    describe "failure" do
      
      it "should not make a new micropost" do
        lambda do
          visit root_path
          fill_in :micropost_content, :with => ""
          click_button
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Micropost, :count)
      end
      
    end
    
    describe "success" do
      
      it "should make a new micropost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :micropost_content, :with => content
          click_button
          response.should have_selector("span.content", :content => content)
        end.should change(Micropost, :count).by(1)
      end
      
      it "should wrap the post content" do
        content = "AbcdefghijklmnopqrstuvwxyzAbcdefghijklmnopqrstuvwxyz"
        visit root_path
        fill_in :micropost_content, :with => content
        click_button
        response.should have_selector("span.content", :content => "d-e")
      end
            
    end
    
  end
  
  describe "sidebar" do
    
    it "should show a single micropost" do
      content = "Lorem ipsum dolor sid amet"
      visit root_path
      fill_in :micropost_content, :with => content
      click_button
      response.should have_selector("span.microposts_count", :content => "1")
    end
    
    it "should show two microposts" do
      content_1 = "Lorem ipsum dolor sid amet"
      visit root_path
      fill_in :micropost_content, :with => content_1
      click_button
      content_2 = "consectetur adipisicing elit"
      fill_in :micropost_content, :with => content_2
      click_button
      response.should have_selector("span.microposts_count", :content => "2")
    end
    
  end
  
  describe "pagination" do
    
    before(:each) do
      @mp1 = Factory(:micropost, :user => @user, :content => "Lorem ipsum dolor sit amet")
      @microposts = [@mp1]
      99.times do
        @microposts << Factory(:micropost, :user => @user, :content => Factory.next(:content))
      end
      @user.microposts = @microposts
    end
    
    it "should paginate microposts" do
      get root_path
      response.should have_selector("div.pagination")
      response.should have_selector("span.disabled", :content => "Previous")
      response.should have_selector("a",  :href => "/?page=2", 
                                          :content => "2")
      response.should have_selector("a",  :href => "/?page=2", 
                                          :content => "Next")
    end
    
  end
  
  describe "delete links" do
    
    before(:each) do
      @user_2 = Factory(:user, :email => "example_2@example.com")
      @user_2.microposts << Factory(:micropost, :user => @user_2, :content => "Can't touch this.") 
    end
    
    it "should not display delete links for another user's micropost" do
      visit user_path(@user_2)
      response.should_not have_selector("a", :content => "delete")
    end
    
  end
              
end
