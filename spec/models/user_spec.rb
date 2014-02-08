require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved without a long password" do
    user = User.create username:"Pekka", password:"p", password_confirmation:"p"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved without a complex password" do
    user = User.create username:"Pekka", password:"Pekka", password_confirmation:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "with another proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved once more" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, still has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "has method for determining the favorite_beer" do
    user = FactoryGirl.create(:user)
    user.should respond_to :favorite_beer
  end

  it "without ratings does not have a favourite beer" do
    user = FactoryGirl.create(:user)
    expect(user.favorite_beer).to eq(nil)
  end

#  it "is the only rated if only one rating" do
#      beer = FactoryGirl.create(:beer)
#      rating = FactoryGirl.create(:rating, beer:beer, user:user)
#
#      expect(user.favorite_beer).to eq(beer)
#  end
end
