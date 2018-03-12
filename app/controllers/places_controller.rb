class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :show]

  def search
    @places = Place.all
    @cuisine_types = CuisineType.all
    @unique_types = @cuisine_types.select(:id,:name).uniq{|a| a.name}.map{ |a| [a.name,a.id]}
    @meal_type = params[:meal_type]
  end

  def show

    @places = Place.all
    @cuisine_types = CuisineType.all
    @unique_types = @cuisine_types.select(:id,:name).uniq{|a| a.name}.map{ |a| [a.name,a.id]}
    raise
    if params.values_at(:place, :radius).all?(&:present?)
      @places = Place.near(params[:place], params[:radius])
    end

    if params[:meal_type].present?
      sql_query = " \
      meal_types.name @@ :meal_type \
      "
      @places = @places.joins(:meal_types).where(sql_query, meal_type: "%#{params[:meal_type]}%")
    end


     if params[:search] && params[:search][:cuisine_types].any? && params[:search][:cuisine_types][1].present?

      sql_query = " \
      cuisine_types.name @@ :cuisine_type \
      "


      @places = @places.where(place_cuisine_types: { cuisine_type_id: params[:search][:cuisine_types] }).includes(:place_cuisine_types).references(:place_cuisine_types)

    end

    if params[:min_price].present?
       # @places = @places.joins(:places).where(sql_query, min_price: "%#{params[:min_price]}%")
       min = params[:min_price].to_i
       @places = @places.where("average_cost_for_two >= ?",min)
     end

     if params[:max_price].present?
       # @places = @places.joins(:places).where(sql_query, min_price: "%#{params[:min_price]}%")
       max = params[:max_price].to_i
       @places = @places.where("average_cost_for_two <= ?",max)
     end

     @place = @places.sample

     @place.places_histories.create(user: current_user)

      # @places = @places.where(address: params[:address])
    end

    def show_id
      @place = Place.find(params[:id])
      render "show"
    end

    def my_places

      @places = current_user.places_histories.order(:id).map(&:place).reverse



    end

    def save_id
      @place = PlacesHistory.where(user_id: current_user, place_id: params[:id])

      if @place.first.rejected == false
        @place.first.update(rejected: true)
      elsif @place.first.rejected == nil
        @place.first.update(rejected: true)
      else
        @place.first.update(rejected: false)
      end

      @places = current_user.places
      redirect_to places_my_places_path

    end


  end
