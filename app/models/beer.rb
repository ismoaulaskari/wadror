include ActionView::Helpers::TextHelper

class Beer < ActiveRecord::Base
  include RatingAverage
  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  validates :name, presence: true
  validates :brewery_id, presence: true
  validates :style, presence: true


#  def average_rating2
#    @sum = 0
#    @no = 0
#    self.ratings.each do |rate| 
#      @sum += rate.score
#      @no = @no + 1
#    end
#    if @no > 0
#      @average = @sum / @no
#    else
#      puts 0
#    end
   
#    self.ratings.each.inject { |sum, n| sum + n }

    #@sum = (self.ratings.each).sum
#    @average = @sum / self.ratings.count

#    @rates = pluralize(@no, "rating")
#    "Has #{@rates}, average #{@average}"
#  end

  def to_s
#    "#{name} #{brewery.name}"
    "#{Brewery.find_by(id:self.brewery_id).name} :  #{self.name}"
  end
end
