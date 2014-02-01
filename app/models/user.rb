class User < ActiveRecord::Base
  include RatingAverage
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validates_format_of :password, {with: /[A-Z]/, with: /[0-9]/}
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_secure_password
end
