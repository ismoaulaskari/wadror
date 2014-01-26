include ActionView::Helpers::TextHelper

class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    @sum = 0
    @no = 0
    self.ratings.each do |rate| 
      @sum += rate.score
      @no = @no + 1
    end
    if @no > 0
      @average = @sum / @no
    else
      puts 0
    end
   
#    self.ratings.each.inject { |sum, n| sum + n }

    #@sum = (self.ratings.each).sum
#    @average = @sum / self.ratings.count

    @rates = pluralize(@no, "rating")
    "Has #{@rates}, average #{@average}"
  end

  def to_s
    "#{Brewery.find_by(id:self.brewery_id).name} :  #{self.name}"
  end
end
