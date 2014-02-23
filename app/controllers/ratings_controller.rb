class RatingsController < ApplicationController
  before_action :ensure_that_signed_in, except: [:index, :show]

  def index
    @ratings = Rating.includes(:beer,:user).all
    @recent_ratings = Rating.includes(:beer,:user).recent
    @top_breweries = Brewery.top(3)
    @top_beers = Beer.includes(:brewery).top(3)
    @top_users = User.includes(:ratings).top(3)
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
end
