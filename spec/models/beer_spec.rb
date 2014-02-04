require 'spec_helper'

describe Beer do

  describe "with an existing brewery the beer belongs to" do
    let(:brewery){ Brewery.create name:"Poff", year:"2014"}

    it "is in an existing brewery" do
      expect(brewery).to be_valid
    end

    it "is saved only with a name and style" do
      beer = Beer.create name:"Myrkky", style:"Porter", brewery_id:brewery.id  
  
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "is not created without a name" do
      beer = Beer.new style:"Porter", brewery_id:brewery.id  
  
      expect(beer).not_to be_valid
    end

    it "is not created without a style" do
      beer = Beer.new name:"Myrkky", brewery_id:brewery.id  
  
      expect(beer).not_to be_valid
    end
 
  end

end
