require 'spec_helper'

describe Blogpost do

  before(:each) do
    @user = Factory(:user)
    @attr = {
      :content => "value for content",
      :title => "value for title",
      :category => "value for categories",
      :published => "true",
    }
  end


  it "should create a new instance given valid attributes" do
    @user.blogposts.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @blogpost = @user.blogposts.create(@attr)
    end

    it "should have a user attribute" do
      @blogpost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @blogpost.user_id.should == @user.id
      @blogpost.user.should == @user
    end
  end

  describe "blogpost associations" do

    before(:each) do
      @user = User.create(@attr)
    end

    it "should have a blogposts attribute" do
      @user.should respond_to(:blogposts)
    end
  end

  describe "validations" do

    it "should require a user id" do
      Blogpost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.blogposts.build(:content => "  ").should_not be_valid
    end

    it "should require nonblank title" do
      @user.blogposts.build(:title => "  ").should_not be_valid
    end

    it "should require nonblank published" do
      @user.blogposts.build(:publised => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.blogposts.build(:title => "a" * 141).should_not be_valid
    end
  end

end
