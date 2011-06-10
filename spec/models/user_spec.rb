require 'spec_helper'

describe User do     
  
  before User do
    
    before(:each) do
      @attr = { 
                :name => "Example User", 
                :email => "user@example.com",
                :password => "foobar",       
                :password_conformation => "foobar"
                }
    end
  
  it "should create a new instance give a valid attribute" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid 
  end 
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
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
    
   it "should reject duplicate emails addresses" do
     User.create!(@attr)
     user_with_duplicate_email = User.new(@attr)
     user_with_duplicate_email.should_not be_valid
   end
   
   it "should reject email addresses identical up to case" do
     upcased_email = @attr[:email].upcase
     User.create!(@attr.merge( :email => upcased_email))
     user_with_duplicate_email = User.new(@attr)
     user_with_duplicate_email.should_not be_valid
   end    
   describe "passwords" do
     
     before(:each) do
       @user = User.new(@attr)
     end
                           
     it "should have a password attribute" do
       @user.should respond_to( :password)
     end                                  
     
     it "shoudl have a password conformation attribute" do
       @user.should respond_to(:password_conformation)
     end
   end  
   
   describe "password validations" do
     it "should require a password" do
       User.new(@attr.merge(:password => "", :password_conformation =>"")).
       should_no be_valid
     end
     
     it "should require a matching conformation" do
       User.new(@attr.merge(:passwork_conformation => "invalid")).
       should_not be_valid
     end
      
   
     it "should reject short passwords" do
       short = "a" * 5
       hash = @attr.merge(:password => short, :password_conformation => short)
       User.new(hash).should_not be_valid
     end
     
     it "should reject short passwords" do
        long = "a" * 41
        hash = @attr.merge(:password => long, :password_conformation => long)
        User.new(hash).should_not be_valid
      end   
    end
end
