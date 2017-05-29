require 'rails_helper'
require 'pry'
describe User do
  describe '#create' do
    it "is invalid without a nickname" do
     user = build(:user,nickname:"")
     user.valid?
     expect(user.errors[:nickname]).to include("can't be blank")
    end
       it "is invalid without a email" do
     user = build(:user,email:"")
     user.valid?
     expect(user.errors[:email]).to include("can't be blank")
       end
       it "is vaild exit email ,password,nickname " do
       user = build(:user)
       expect(user).to be_valid
       end
       it "is invalid without a password" do
       user = build(:user,password:"")
       user.valid?
       expect(user.errors[:password]).to include("can't be blank")
       end
       it "is invalid exit a password and without a password_confirmation" do
       user = build(:user,password_confirmation:"")
       binding.pry
       user.valid?
       expect(user.errors[:password_confirmation]).to include("can't be blank")
      end
      it "is invalid nickname 7letters" do
        user = build(:user,nickname:"aaaaaaa")
        user.valid?
       expect(user.errors[:nickname][0]).to include("is too long")
      end
      it "is valid nickname 6letters" do
      end
      it "is invalid duble emails" do
        user = create(:user)
        another_user = build(:user,email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("has already been taken")
      end
      it "is valid password 8letters" do
      end
      it "is invalid password 7letters" do
      end

  end
end
