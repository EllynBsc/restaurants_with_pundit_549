class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[ show edit update destroy ]

  # GET /restaurants or /restaurants.json
  def index
    # @restaurants = Restaurant.all
    # authorize(@restaurants)
    @restaurants = policy_scope(Restaurant)
  end

  # GET /restaurants/1 or /restaurants/1.json
  def show
    # .show? policy
    authorize(@restaurant)
  end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
    # need to call the .new? method from the restaurant to make sure the user can see the form
    authorize(@restaurant) # .new?
  end

  # GET /restaurants/1/edit
  def edit
    # .edit?
    authorize(@restaurant)
  end

  # POST /restaurants or /restaurants.json
  def create
    @restaurant = Restaurant.new(restaurant_params)
    # assign the current_user to the restaurant created
    @restaurant.user = current_user
    # need to call the .create? method from the restaurant to make sure the user can create a restaurant
    authorize(@restaurant)#.create?

    if @restaurant.save
     render :show
    else
     render :new
    end
  end

  # PATCH/PUT /restaurants/1 or /restaurants/1.json
  def update
    if @restaurant.update(restaurant_params)
      # .update?
      authorize(@restaurant)
      redirect_to @restaurant

    else
      render :edit
    end
  end

  # DELETE /restaurants/1 or /restaurants/1.json
  def destroy
    @restaurant.destroy
    authorize(@restaurant) #calling the .destroy? from the restaurants policy
    redirect_to restaurants_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def restaurant_params
    params.require(:restaurant).permit(:name, :user_id)
  end
end
