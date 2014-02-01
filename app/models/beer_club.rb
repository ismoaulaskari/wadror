class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :users, -> { uniq }, through: :memberships
end
