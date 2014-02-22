class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validates_format_of :password, {with: /[A-Z]/, with: /[0-9]/}
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships
  has_many :beer_clubs, -> { uniq }, through: :memberships

  has_secure_password

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

  def to_s
    #"#{User.find_by(id:self.user_id).username} :  #{self.username}"
    "#{self.username}"
  end
end
