class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  def username
    user.username
  end

  def to_s
    "#{beer.name} #{score}"
  end
end
