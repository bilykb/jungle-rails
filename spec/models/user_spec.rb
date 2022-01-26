require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    context 'When creating a new user' do
      it "is valid with valid attributes" do
        user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")

        expect(user).to be_valid
      end

      it "has password == password_confirmation" do
        user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")

        expect(user.password).to eq(user.password_confirmation)
      end

      it "fails to create a new user if the email is not unique" do
        # also tests for edge cases involving case sensitivity
        user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")
        
        second_user = User.create(email: "FUN_STUFF@GMAIL.com", password: "string_password", password_confirmation: "string_password")

        expect(second_user.errors.full_messages).to include("Email has already been taken")
      end

      it "fails to create a new user if the password length is < 5" do
        user = User.create(email: "fun_stuff@gmail.com", password: "pass", password_confirmation: "pass")

        expect(user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
      end
    end
  end
  
  describe '.authenticate_with_credentials' do
    context 'when making a new session' do
      it 'returns a user if the user exists within the database' do
        user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")

        expect(User.authenticate_with_credentials(user.email, user.password)).to be_instance_of(User)
      end

      it 'returns nil if the user does not exist in the database' do
        expect(User.authenticate_with_credentials("hello@gmail.com", "password")).to be_nil
      end

      it 'removes for and rear whitespace of email, calls .lowcase on email, and returns user' do
        user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")

        expect(User.authenticate_with_credentials("   FUN_STUFF@GMAIL.COM   ", "string_password")).to be_instance_of(User)
      end
    end
  end
end
