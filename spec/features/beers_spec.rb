require 'spec_helper'

include OwnTestHelper

describe "User" do
  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
    FactoryGirl.create :brewery
  end

  describe "signed up user on beer creation" do
    it "can create beer with valid name" do
      visit new_beer_path
      fill_in('beer[name]', with:'Yrjo')
      select("anonymous", from:'beer[brewery_id]')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "is redirected back if invalid name given" do
      visit new_beer_path
      select("anonymous", from:'beer[brewery_id]')
      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
    end
  end
end

