class PoisController < ApplicationController
  def index
    if params[:city].present?
      @pois = Poi.where(city: params[:city]).where(state: params[:state])
      # @pois = Poi.where('lower(city) = ?', "%#{params[:city].downcase}%") if params[:city].present?
      # @pois = Poi.where('lower(city) ILIKE ?', "%#{params[:city].downcase}%") if params[:city].present?
      @poi_pins = @pois.map { |f| 
        { id:       f.id,
          lat:      f.lat, 
          lng:      f.lng, 
          label:    f.name, 
          tooltip:  self.poi_details(f).downcase.titleize
        } 
      }
    else
      @current_latitude = '37.7749'
      @current_longitude = '-122.4194'
      @poi_pins = [{ lat: @current_latitude, lng: @current_longitude, label: 'San Francisco',
                     tooltip: "<b>Hello you San Francisco</b>" }]
    end
  end

  def autocomplete
    @pois = Poi.where('lower(city) LIKE ? OR lower(state) LIKE ?', "%#{params[:q].downcase}%",
                      "%#{params[:q].downcase}%")
    render turbo_stream: turbo_stream.replace(
      'search-results',
      partial: 'pois/autocomplete_results',
      locals: { pois: @pois }
    )
  end

  def search
    if params[:search].present?
      @search_query = params[:search]
      @pois = Poi.where('city ILIKE ?', "%#{@search_query}%")
                 .group(:city, :state).count

    # @pois = Poi.where('city ILIKE ?', "%#{params[:search]}%").distinct

    else
      @pois = []
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.update('search_results',
                              partial: 'pois/search_results',
                              locals: { pois: @pois })
      end
    end
  end

  # GET /pois/1 or /pois/1.json
  def show
    @poi = Poi.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def poi_details(poi)
    text = render_to_string partial: 'poi_details', locals: { poi: poi }
    CGI.unescapeHTML(text).html_safe
  end
end
