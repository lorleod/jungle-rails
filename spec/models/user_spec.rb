require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should not save without a password field' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: nil,
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not save without a password confirmation field' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: nil,
        email: "example@example.com"
      )
      user.save
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should not save if password and password confirmation do not match' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "differentpassword",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not save if password length is less than 8 characters' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "pass",
        password_confirmation: "pass",
        email: "example@example.com"
      )
      user.save
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it 'should not save without an email field' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "nil"
      )
      user.save
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it 'should not save if email is not unique (case insensitive)' do
      user1 = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "user1@example.com"
      )
      user1.save

      user2 = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "User1@example.com"
      )
      user2.save
      expect(user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not save without a first name field' do
      user = User.new(
        first_name: nil,
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not save without a last name field' do
      user = User.new(
        first_name: "first",
        last_name: nil,
        password: "password",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should not authenticate with incorrect password' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save

      expect(User.authenticate_with_credentials("example@example.com","word")).to equal(nil)
    end

    it 'should authenticate with correct password' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save

      expect(user).to eql(User.authenticate_with_credentials("example@example.com","password"))
    end

    it 'should authenticate with different case email' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save

      expect(user).to eql(User.authenticate_with_credentials("eXample@example.com","password"))
    end

    it 'should authenticate even with whitespace' do
      user = User.new(
        first_name: "first",
        last_name: "last",
        password: "password",
        password_confirmation: "password",
        email: "example@example.com"
      )
      user.save

      expect(user).to eql(User.authenticate_with_credentials("  example@example.com  ","password"))
    end
  end
end
