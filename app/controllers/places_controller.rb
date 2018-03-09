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


    @place = @places.sample




      # @places = @places.where(address: params[:address])
  end


def show_id

@place = Place.find(params[:id])
render "show"

end

end
