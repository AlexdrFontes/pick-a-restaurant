class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :show]

  def search
    @places = Place.all
    @cuisine_types = CuisineType.all
    @unique_types = @cuisine_types.select(:name).uniq.map(&:name)
  end

  def show

    @places = Place.all
    @cuisine_types = CuisineType.all
    @unique_types = @cuisine_types.select(:name).uniq.map(&:name)

    if params.values_at(:place, :radius).all?(&:present?)
    @places = Place.near(params[:place], params[:radius])
    end

    if params[:meal_type].present?
      sql_query = " \
        meal_types.name @@ :meal_type \
       "
       @places = @places.joins(:meal_types).where(sql_query, meal_type: "%#{params[:meal_type]}%")
    end


    if params[:search][:cuisine_types][1].present?

      sql_query = " \
        cuisine_types.name @@ :cuisine_type \
       "
      params[:search][:cuisine_types][1..-1].each do |type|
        type = CuisineType.find_by(name: type)
        @places._select! do |place|
          place.cuisine_types.include? type
        end
        raise
      end
      # @places = @places.joins(:cuisine_types).where(sql_query, cuisine_type: "%#{params[:search][:cuisine_types]}%")
    end
      # @places = @places.where(address: params[:address])
  end
end
