require 'spec_helper'

describe "Beerlist page" do
  before :all do
    self.use_transactional_fixtures = false
    WebMock.disable_net_connect!(allow_localhost:true)
  end

  before :each do
    @brewery1 = FactoryGirl.create(:brewery, name:"Koff")
    @brewery2 = FactoryGirl.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryGirl.create(:brewery, name:"Ayinger")
    @style1 = "Lager"
    @style2 = "Rauchbier"
    @style3 = "Weizen"
    @beer1 = FactoryGirl.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryGirl.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryGirl.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  after :each do
    DatabaseCleaner.clean
  end

  after :all do
    self.use_transactional_fixtures = true
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(2)')
    expect(page).to have_content "Nikolai"
  end

  describe "Beerlist ordering" do
    before :each do
      @count = 2
      visit beerlist_path
      find('table').find('tr:nth-child(2)')
    end

    it "seems that beers are ordered by name", js:true do
      @allbeers = ["Fastenbier", "Lechte Weisse","Nikolai"]
      @allbeers.each do |b| 
        find('table').find("tr:nth-child(#{@count})").should have_content(b)
        @count += 1  
      end  
    end

    it "seems that beers are ordered by style when clicked", js:true do
      click_link('style')
      @allstyles = ["Lager", "Rauchbier", "Weizen"]
      @allstyles.each do |b| 
        find('table').find("tr:nth-child(#{@count})").should have_content(b)
        @count += 1  
      end  
    end

  end

end
