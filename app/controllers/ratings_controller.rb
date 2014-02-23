class RatingsController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]

  def index
    Rails.cache.write("recent_ratings", Rating.includes(:beer,:user).recent) if cache_does_not_contain_data_or_it_is_too_old
    @recent_ratings = Rails.cache.read("recent_ratings")

    Rails.cache.write("brewery_top", Brewery.top(3)) if cache_does_not_contain_data_or_it_is_too_old
    @top_breweries = Rails.cache.read("brewery_top")

    Rails.cache.write("beer_top", Beer.includes(:brewery).top(3)) if cache_does_not_contain_data_or_it_is_too_old
    @top_beers = Rails.cache.read("beer_top")

    Rails.cache.write("user_top", User.includes(:ratings).top(3)) if cache_does_not_contain_data_or_it_is_too_old
    @top_users = Rails.cache.read("user_top")

    #tämä kirjoitettava viimeisenä tai kosahtaa!
    Rails.cache.write("ratings-all", Rating.includes(:beer,:user).all, expires_in:2.minutes) if cache_does_not_contain_data_or_it_is_too_old
    @ratings = Rails.cache.read("ratings-all")
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)

    if current_user.nil?
        redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      session[:last_rating] = "#{@rating.beer.name} #{@rating.score} points"
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end

  end

 def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back 
  end

  private
  def cache_does_not_contain_data_or_it_is_too_old
    Rails.cache.read("ratings-all").nil?
  end
end
