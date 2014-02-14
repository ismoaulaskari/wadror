class PlacesController < ApplicationController
  def index
  end

  def show
    unless session[:search_city].nil?
      @places = BeermappingApi.places_in(session[:search_city])
      unless @places.nil?
        @place = @places.find(id: params[:id]).first
      end
    end
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    session[:search_city] = params[:city]

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end
