class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :show]

  def show
    @places = Place.all

    if params.values_at(:city, :radius).all?(&:present?)
    @places = Place.near(params[:city], params[:radius])
    end

    if params[:cuisine_type].present?
      sql_query = " \
        cuisine_types.name @@ :cuisine_type \
       "
      @places = @places.joins(:cuisine_types).where(sql_query, cuisine_type: "%#{params[:cuisine_type]}%")
    end

      # @places = @places.where(address: params[:address])
  end
end
