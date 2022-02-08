require 'rails_helper'
#test both successful case, then write test for when errors come up
describe User, type: :model do
  it 'has matching password and password_confirmation' do
    user = User.new(first_name:"Alice", last_name:"Johnson", email:"alice.j@mail.com", password: "password", password_confirmation:"password")
    user.save
    #pp "---->", @user.errors.full_messages
    #expect(@product.errors.full_messages).to be_present
    expect(user.errors.full_messages).to eq([])
    #expect(@product.name).to be_nil
  end
  it 'has mismatching password and password_confirmation' do
    user = User.new(first_name:"Alice", last_name:"Johnson", email:"alice.j@mail.com", password: "password", password_confirmation:"mismatch")
    user.save
    #pp "---->", @user.errors.full_messages
    #expect(@product.errors.full_messages).to be_present
    expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end
  it 'does not already have email in database' do
    user = User.new(first_name:"Alice", last_name:"Johnson", email:"alice.j@mail.com", password: "password", password_confirmation:"password")
    user.save #you use a bang! when you expect success, and if for some reason it doesn't succeed, it will show you an error, if it fails at ! then the rest of the code doesn't run
    user2 = User.new(first_name:"Alice", last_name:"Johnson", email:"alice.j@mail.com", password: "password", password_confirmation:"password")
    user2.save
    expect(user2.errors.full_messages).to include("Email has already been taken")

  end
  it 'must have an email' do
    user = User.new(first_name:"Alice", last_name:"Johnson", password: "password", password_confirmation:"password")
    user.save #not using bang allows test to fail silently and run the rest of the block of code
    #pp "---->", @user.errors.full_messages
    expect(user.errors.full_messages).to include("Email can't be blank")
  end
  it 'must have a first name' do
    user = User.new(last_name:"Johnson", password: "password", password_confirmation:"password", email:"alice.j@mail.com")
    user.save #not using bang allows test to fail silently and run the rest of the block of code
    #pp "---->", @user.errors.full_messages
    expect(user.errors.full_messages).to include("First name can't be blank")
  end
  it 'must have a last name' do
    user = User.new(first_name:"Alice", password: "password", password_confirmation:"password", email:"alice.j@mail.com")
    user.save #not using bang allows test to fail silently and run the rest of the block of code
    #pp "---->", @user.errors.full_messages
    expect(user.errors.full_messages).to include("Last name can't be blank")
  end
  it 'must have a password with minimum 6 characters' do
    user = User.new(first_name:"Alice", last_name:"Johnson", password: "pass", password_confirmation:"pass", email:"alice.j@mail.com")
    user.save 
    #pp "---->", @user.errors.full_messages
    expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end
end

describe '.authenticate_with_credentials' do
 it 'will login the user with valid email and password' do
  #User.create combines both .new and .save when you have all the form fields you need, if you want to build the user incrementally then you'd use .save seperately, you could have changed all the tests above to use only .create

  #you also do not need @ because you are creating many unnecessary global variables, they do not need to be accessess outside test block
     User.create(first_name:"Alice", last_name:"Johnson", password: "password", password_confirmation:"password", email:"alice.j@mail.com")

    #by calling .authenticate_with_cred on User class we are using the method defined in the User class, and we go to the WHOLE table of users, if you call .authenticate on user it is only trying to call an undefined method on one record you just created. 
    user = User.authenticate_with_credentials("alice.j@mail.com","password")
    #pp user
    expect(user.id).to be_present #you want to check for id to thoroughly check that the user has been added to database,otherwise doing .create or .new will create a user but doesn't mean it's in database 
  end

 it 'will not login in user and will return nil if email does not exist' do
  User.create(first_name:"Alex", last_name:"John", password: "flower", password_confirmation:"flower", email:"alex.j@mail.com")
  user = User.authenticate_with_credentials("p@mail.com","password")
  expect(user).to be_nil #can't call user.id cause if it's nil, and looking for .id on nil = error
  end
  
  it 'will login email with spaces in the front and end' do
    User.create(first_name:"Alex", last_name:"John", password: "flower", password_confirmation:"flower", email:"alex.j@mail.com")
    user = User.authenticate_with_credentials(" alex.j@mail.com ","flower")
    #pp user
    expect(user.id).to be_present #can't call user.id cause if it's nil, and looking for .id on nil = error
    end

  it 'will login email with capitals' do
    User.create(first_name:"Alex", last_name:"John", password: "flower", password_confirmation:"flower", email:"alex.j@mail.com")
    user = User.authenticate_with_credentials(" AlEx.J@MAiL.com ","flower")
    #pp user
    expect(user.id).to be_present #can't call user.id cause if it's nil, and looking for .id on nil = error
    end

 it 'will not login in user and will return nil if password is incorrect' do

  User.create(first_name:"Alex", last_name:"John", password: "flower", password_confirmation:"flower", email:"alex.j@mail.com")
  user = User.authenticate_with_credentials("alex.j@mail.com","passwordpassword")
  expect(user).to be_nil #can't call user.id cause if it's nil, and looking for .id on nil = error
  end

   
end