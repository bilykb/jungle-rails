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
        user = User.create(email: "fun_stuff@gmail.com", password: "string_password", password_confirmation: "string_password")
        
        second_user = User.create(email: "FUN_STUFF@GMAIL.com", password: "string_password", password_confirmation: "string_password")

        expect(second_user.errors.full_messages).to eq(["Email has already been taken"])
      end
    end
  end
end
