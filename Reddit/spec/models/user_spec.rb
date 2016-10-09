require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_presence_of(:email) }
  end

  describe "associations" do
    it { should have_many(:subs) }
    it { should have_many(:votes) }
    it { should have_many(:comments) }
  end

  describe "auth methods" do
    before(:each) do
      @user = User.create!(username: "test", email: "test@me.com", password: "testtest")
    end

    describe "#is_password?" do
      it "returns the correct result" do
        expect(@user.is_password?("testtest")).to be_truthy
      end
    end

    describe "#reset_session_token!" do
      it "resets the session token" do
        old_token = @user.session_token
        @user.reset_session_token!
        expect(@user.session_token).not_to eq(old_token)
      end
    end

    describe "::find_by_credentials" do
      it "finds the correct user" do
        expect(User.find_by_credentials("test", "testtest")).to eq(@user)
      end
    end
  end
end
