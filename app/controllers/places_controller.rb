class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @user = User.find_by({ "id" => session["user_id"] })

    if @user != nil
      @entries = Entry.where({ "user_id" => @user["id"], "place_id" => @place["id"] })
    else
    flash["notice"] = "You must be logged in to see posts."
    redirect_to "/login"
    end
  end

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @place = Place.new
    @place["name"] = params["name"]
    @place.save
    redirect_to "/places"
  end

end
