class NrelLocation < ApplicationRecord
  include HTTParty

  def self.collect_locations_in_a_city(city:, state:, api_key: self.api_key)
    url = "https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?location=#{city}+#{state}&fuel_type=ELEC&api_key=#{api_key}"
    response = HTTParty.get(url)
    charging_stations_data = response['fuel_stations']
    puts '================'
    charging_stations_data
    return if charging_stations_data.nil?

    # response.first
    charging_stations_data.each do |data|
      loc = where(nrel_id: data['id']).first_or_create do |data|
        nrel_id = data['id'],
                  date_last_confirmed = data['date_last_confirmed'],
                  expected_date = data['expected_date'],
                  station_name = data['station_name'],
                  station_phone = data['station_phone'],
                  api_updated_at = data['updated_at'],
                  street_address = data['street_address'],
                  city = data['city'],
                  state = data['state'],
                  zip = data['zip'],
                  intersection_directions = data['intersection_directions'],
                  ev_connector_types = data['ev_connector_types'],
                  latitude = data['latitude'],
                  longitude = data['longitude'],
                  distance = data['distance'],
                  fuel_type_code = data['fuel_type_code'],
                  ev_dc_fast_num = data['ev_dc_fast_num'],
                  ev_level1_evse_num = data['ev_level1_evse_num'],
                  ev_level2_evse_num = data['ev_level2_evse_num'],
                  ev_network = data['ev_network'],
                  ev_network_web = data['ev_network_web'],
                  access_days_time = data['access_days_time'],
                  ev_network_ids = data['ev_network_ids']
      end

      loc.update(nrel_id: data['id'],
                 date_last_confirmed: data['date_last_confirmed'],
                 expected_date: data['expected_date'],
                 station_name: data['station_name'],
                 station_phone: data['station_phone'],
                 api_updated_at: data['updated_at'],
                 street_address: data['street_address'],
                 city: data['city'],
                 state: data['state'],
                 zip: data['zip'],
                 intersection_directions: data['intersection_directions'],
                 ev_connector_types: data['ev_connector_types'],
                 latitude: data['latitude'],
                 longitude: data['longitude'],
                 distance: data['distance'],
                 fuel_type_code: data['fuel_type_code'],
                 ev_dc_fast_num: data['ev_dc_fast_num'],
                 ev_level1_evse_num: data['ev_level1_evse_num'],
                 ev_level2_evse_num: data['ev_level2_evse_num'],
                 ev_network: data['ev_network'],
                 ev_network_web: data['ev_network_web'],
                 access_days_time: data['access_days_time'],
                 ev_network_ids: data['ev_network_ids'])
    end
  end
  #  ===
  # ...

  def self.fetch_locations(state_code:, api_key: self.api_key)
    # fetch location data from the NREL API for the given state code
    url = "https://developer.nrel.gov/api/alt-fuel-stations/v1.json?state=#{state_code}&fuel_type=ELEC&api_key=#{api_key}"

    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    # loop over each location in the API response
    data['fuel_stations'].each do |station|
      # find or initialize an NrelLocation record with the given api_id
      nrel_location = NrelLocation.find_or_initialize_by(api_id: station['id'])

      # update the fields on the NrelLocation record with the data from the API
      nrel_location.update!(
        name: station['station_name'],
        street_address: station['street_address'],
        latitude: station['latitude'],
        longitude: station['longitude'],
        state: station['state'],
        city: station['city'],
        zip: station['zip'],
        ev_level1_evse_num: station['ev_level1_evse_num'],
        ev_level2_evse_num: station['ev_level2_evse_num'],
        ev_dc_fast_num: station['ev_dc_fast_num'],
        ev_network: station['ev_network'],
        ev_network_web: station['ev_network_web'],
        phone: station['station_phone'],
        distance: station['distance'],
        hours: station['access_days_time'],
        owner_type_code: station['owner_type_code'],
        fuel_type_code: station['fuel_type_code'],
        updated_at: station['updated_at']
      )
    end
  end

  #  ====
  def self.collect_all_location_of_us_by_state(country_abbr: 'US', api_key: self.api_key)
    # CS chokes occasionally.  Just try again.
    state_symbols = %i[
      AK AL AR AZ CA CO CT DC DE FL
      GA HI IA ID IL IN KS KY LA MA
      MD ME MI MN MO MS MT NC ND NE
      NH NJ NM NV NY OH OK OR PA RI
      SC SD TN TX UT VA VT WA WI WV
      WY
    ]
    states = state_symbols.map { |x| x.to_s }

    states.each do |state|
      puts '################################'
      puts "starting #{state}"
      puts '################################'
      sleep 0.5
      fetch_locations(state_code: state, api_key:)
    end
  end

  def formatted_address
    # nl_formatted_address = "#{street_address}, #{city}, #{state} #{zip}"
    country ||= 'United States'
    [street_address, city, "#{state} #{zip}", country].compact.join(', ')
  end

  def self.api_key
    Rails.application.credentials.dig(:nrel_developer_network, :api_key)
  end
end
