require 'rails_helper'

RSpec.describe User, type: :model do

  describe "Create an User with an invalid email " do
    it "shouldn't be permitted" do
      user = User.create(email: 'user',
                   password: 'password1234',
                   password_confirmation: 'password1234')
      expect(user).to_not be_valid
    end
  end

  describe "Create an User without an email " do
    it "shouldn't be permitted" do
      user = User.create(password: 'password1234',
                         password_confirmation: 'password1234')
      expect(user).to_not be_valid
    end
  end

  describe "Create an User without a password " do
    it "shouldn't be permitted" do
      user = User.create(email: 'test@test.com', password_confirmation: 'password1234')
      expect(user).to_not be_valid
    end
  end

  describe "Create an User with password and password_confirmation with different values " do
    it "shouldn't be permitted" do
      user = User.create(email: 'test@test.com', password: 'hello', password_confirmation: 'password1234')
      expect(user).to_not be_valid
    end
  end

  describe "Create an User with a password shorter than 6 characters " do
    it "shouldn't be permitted" do
      user = User.create(email: 'test@test.com', password: 'hello', password_confirmation: 'hello')
      expect(user).to_not be_valid
    end
  end

  describe "Create a new User with a valid email and password" do
    it "should have only the default role :user" do
      user = User.create(email: 'test@test.com', password: 'password1234', password_confirmation: 'password1234')
      result = true
      if !user.has_role?(:user)
        result = false
      end
      for role in User::ROLES
        if role != :user and user.has_role?(role)
          result=false
        end
      end
      expect(result).to eq(true)
    end
  end

  describe "Create an User with a valid email and password " do
    it "should be permitted" do
      user = User.create(email: 'test@test.com', password: 'password1234',  password_confirmation: 'password1234')
      expect(user).to be_valid
    end
  end
end
