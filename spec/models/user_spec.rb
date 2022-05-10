require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'saves a user when password and password_confirmation match' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'testing@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.validate
      expect(user.errors.full_messages).to be_empty
    end

    it 'does not save a user without password' do
      user = User.new(email: 'testing@gmail.com', password_confirmation: '12345678')
      user.validate
      expect(user.errors.full_messages).to include(
        "Password can't be blank",
        "Password confirmation doesn't match Password"
      )
    end

    it 'does not save user without password_confirmation' do
      user = User.new(email: 'testing@gmail.com', password: '12345678')
      user.validate
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'does not save user on password and password_confirmation mismatch' do
      user = User.new(email: 'testing@gmail.com',
        password: '12345678',
        password_confirmation: '123456789'
      )
      user.validate
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    
    it 'does not save user if email address is not unique' do
      User.create(
        first_name: 'Jeff',
        last_name: 'Doe',
        email: 'jeff@jeffsworld.com',
        password: 'abcdefgh',
        password_confirmation: 'abcdefgh'
      )
      user = User.new(
        first_name: 'Jeff',
        last_name: 'Doe',
        email: 'jeff@jeffsworld.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.validate
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'does not save user if email address is not unique' do
      User.create(
        first_name: 'Jeff',
        last_name: 'Doe',
        email: 'jeff@jeffsworld.com',
        password: 'abcdefgh',
        password_confirmation: 'abcdefgh'
      )
      user = User.new(
        first_name: 'Jeff',
        last_name: 'Doe',
        email: 'jEFf@jEFFSworld.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.validate
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
    
    it 'does not save user without email address' do
      user = User.new(first_name: 'Jeff',
        last_name: 'Doe',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.validate
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'does not save user without first name' do
      user = User.new(
        last_name: 'Doe',
        email: 'jeff@jeffsworld.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.validate
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'does not save user without last name' do
      user = User.new(first_name: 'Jeff',
        email: 'jeff@jeffsworld.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
      user.validate
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'does not save user if password is less than 8 characters in length' do
      user = User.new(first_name: 'John',
        last_name: 'Doe',
        email: 'testing@gmail.com',
        password: '1234567',
        password_confirmation: '1234567'
      )
      user.validate
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
      
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      User.create(first_name: 'John',
        last_name: 'Doe',
        email: 'testing@gmail.com',
        password: '12345678',
        password_confirmation: '12345678'
      )
    end

    it 'returns the User if the email and password are correct' do
      authentication_response = User.authenticate_with_credentials('testing@gmail.com', '12345678')
      user = User.find_by(email: 'gonzonieto@gmail.com')
      expect(authentication_response).to equal(user)
    end

    it 'ignores email case' do
      authentication_response = User.authenticate_with_credentials('testing@gmail.com', '12345678')
      user = User.find_by(email: 'gONzonIETo@gmail.com')
      expect(authentication_response).to equal(user)
    end
    
    it 'returns nil if password is incorrect' do
      authentication_response = User.authenticate_with_credentials('testing@gmail.com', '1234567778')
      expect(authentication_response).to be_nil
    end

    it 'returns nil if email is incorrect' do
      authentication_response = User.authenticate_with_credentials('testiiuoung@gmasdasd.com', 12345678)
      expect(authentication_response).to be_nil
    end
    
  end
end