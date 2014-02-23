class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_breweries_and_styles_for_template, only: [:new, :edit, :create]
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :skip_if_cached, only:[:index]

  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.includes(:brewery, :ratings).all
    order = params[:order] || 'name'

    case order
      when 'name' then @beers.sort_by!{ |b| b.name }
      when 'brewery' then @beers.sort_by!{ |b| b.brewery.name }
      when 'style' then @beers.sort_by!{ |b| b.style }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
    @breweries = Brewery.all
  end

  # GET /beers/1/edit
  def edit
    @breweries = Brewery.all
  end

  # POST /beers
  # POST /beers.json
  def create
    expire
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @beer }
      else
        format.html { render action: 'new' }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    expire
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    expire
    if ensure_that_admin
      @beer.destroy
      respond_to do |format|
        format.html { redirect_to beers_url }
        format.json { head :no_content }
      end
    end
  end

  def list
  end

  def nglist
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style, :brewery_id)
    end

  def set_breweries_and_styles_for_template
    @breweries = Brewery.all
    @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
  end

  def expire
    ["beerlist-name", "beerlist-brewery", "beerlist-style"].each{ |f| expire_fragment(f) } 
  end

  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "beerlist-#{params[:order]}"  )
  end
end
