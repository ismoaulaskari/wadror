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
    @average = @sum / @no

#    self.ratings.each.inject { |sum, n| sum + n }

    #@sum = (self.ratings.each).sum
#    @average = @sum / self.ratings.count

    "Has #{@no} ratings, average #{@average}"
  end

  def to_s
    self.name
  end
end
