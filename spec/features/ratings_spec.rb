require 'spec_helper'
include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }


  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "2 ratings in the db" do
    let!(:beer) { FactoryGirl.create(:beer) }
    let!(:rating1) { FactoryGirl.create :rating, beer:beer, user:user }
    let!(:rating2) { FactoryGirl.create :rating2, beer:beer, user:user }

    it "is said that the ratings database matches the page" do
       visit ratings_path
       expect(page).to have_content "#{beer.name} #{rating1.score} #{rating1.user.username}" 
       expect(page).to have_content "#{beer.name} #{rating2.score} #{rating2.user.username}" 
       expect(page).to have_content "#{Rating.count} ratings"
    end
    it "is said that user's page has his ratings and nobody elses" do
       visit user_path(user)
       expect(page).to have_content "#{beer.name} : #{rating1.score}" 
       expect(page).to have_content "#{beer.name} : #{rating2.score}" 
       expect(page).to have_content "User has made 2 ratings"
    end
     it "when deleted, ratings disappear from the database" do
       visit user_path(user)
       expect(page).to have_content "#{beer.name} : #{rating1.score}" 
       expect(page).to have_content "#{beer.name} : #{rating2.score}" 
       expect(page).to have_content "User has made 2 ratings"
       expect{
         find(:xpath, "(//a[text()='delete'])[2]").click
       }.to change{Rating.count}.from(2).to(1)
      save_and_open_page
    end
 
  end

end

