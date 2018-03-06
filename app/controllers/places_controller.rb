class PlacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search, :show]

  def show
    @places = Place.all
    if params[:cuisine_type].present?
      sql_query = " \
        cuisine_types.name @@ :cuisine_type \
       "
      @places = @places.joins(:cuisine_types).where(sql_query, cuisine_type: "%#{params[:cuisine_type]}%")
    end

    if params[:location].present?
      @places = @places.where(city: params[:location].capitalize)
    end
  end
end
# OR places.city @@ :search \
