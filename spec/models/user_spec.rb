require 'spec_helper'

describe User do

  before(:each) do
    @attr = { 
      :login => "bmarley",
      :firstname => "Bob",
      :lastname => "Marley",
      :email => "bob@marley.com",
      :password => "foobar",
      :password_confirmation => "foobar"
  }
  end

  it "should create a new instance given valid attributes" do
     User.create!(@attr)
  end

  it "should require a firstname" do
    no_firstname_user = User.new(@attr.merge(:firstname => ""))
    no_firstname_user.should_not be_valid
  end
  
  it "should require a lastname address" do
     no_lastname_user = User.new(@attr.merge(:lastname => ""))
     no_lastname_user.should_not be_valid
  end

  it "should require an email address" do
     no_email_user = User.new(@attr.merge(:email => ""))
     no_email_user.should_not be_valid
   end
   
  it "should reject firstnames that are too long" do
    long_firstname = "a" * 51
    long_firstname_user = User.new(@attr.merge(:firstname => long_firstname))
    long_firstname_user.should_not be_valid 
  end
     
  it "should reject lastnames that are too long" do
    long_lastname = "a" * 51
    long_lastname_user = User.new(@attr.merge(:lastname => long_lastname))
    long_lastname_user.should_not be_valid
  end
  
  it "should reject login that are too long" do
    long_login = "a" * 21
    long_login_user = User.new(@attr.merge(:login => long_login))
    long_login_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
      addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      addresses.each do |address|
        valid_email_user = User.new(@attr.merge(:email => address))
        valid_email_user.should be_valid
      end
  end

  it "should reject invalid email addresses" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database.
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject duplicate login" do
      # Put a user with given login
      User.create!(@attr)
      user_with_duplicate_login = User.new(@attr)
      user_with_duplicate_login.should_not be_valid
  end

  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
      should_not be_valid
    end

     it "should require a matching password confirmation" do
       User.new(@attr.merge(:password_confirmation => "invalid")).
         should_not be_valid
     end

     it "should reject short passwords" do
       short = "a" * 3
       hash = @attr.merge(:password => short, :password_confirmation => short)
       User.new(hash).should_not be_valid
     end

     it "should reject long passwords" do
       long = "a" * 17
       hash = @attr.merge(:password => long, :password_confirmation => long)
       User.new(hash).should_not be_valid
     end
   end

   describe "password encryption" do

       before(:each) do
         @user = User.create!(@attr)
       end

       it "should have an encrypted password attribute" do
         @user.should respond_to(:encrypted_password)
       end
       
       it "should set the encrypted password" do
             @user.encrypted_password.should_not be_blank
       end
     
       describe "has_password? method" do

         it "should be true if the passwords match" do
           @user.has_password?(@attr[:password]).should be_true
         end    

         it "should be false if the passwords don't match" do
           @user.has_password?("invalid").should be_false
         end 
      end
      
      describe "authenticate method" do

            it "should return nil on email/password mismatch" do
              wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
              wrong_password_user.should be_nil
            end

            it "should return nil for an email address with no user" do
              nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
              nonexistent_user.should be_nil
            end

            it "should return the user on email/password match" do
              matching_user = User.authenticate(@attr[:email], @attr[:password])
              matching_user.should == @user
            end
          end         
   end

  describe "admin attribute" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end


  describe "blogpost associations" do

    before(:each) do
      @user = User.create(@attr)
      @mp1 = Factory(:blogpost, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:blogpost, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @user.should respond_to(:blogposts)
    end

    it "should have the right microposts in the right order" do
      @user.blogposts.should == [@mp2, @mp1]
    end
  end
      
end