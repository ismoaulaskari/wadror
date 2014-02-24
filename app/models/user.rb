class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 35 }
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

def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.username = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    password = (0...8).map { (65 + rand(26)).chr }.join + 'ZA9' 
    user.password = password
    user.password_confirmation = password
    user.save!
  end
end

  def to_s
    #"#{User.find_by(id:self.user_id).username} :  #{self.username}"
    "#{self.username}"
  end
end
