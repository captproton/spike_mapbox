class CreateNrelLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :nrel_locations do |t|
      t.string :access_code
      t.string :access_days_time
      t.string :access_detail_code
      t.string :cards_accepted
      t.string :date_last_confirmed
      t.string :expected_date
      t.string :fuel_type_code
      t.string :groups_with_access_code
      t.integer :api_id
      t.string :open_date
      t.string :owner_type_code
      t.string :status_code
      t.string :restricted_access
      t.string :station_name
      t.string :station_phone
      t.datetime :api_updated_at, default: nil
      t.string :facility_type
      t.string :geocode_status
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :city
      t.string :intersection_directions
      t.string :plus4
      t.string :state
      t.string :street_address
      t.string :zip
      t.string :country
      t.string :bd_blends
      t.string :cng_dispenser_num
      t.string :cng_fill_type_code
      t.string :cng_psi
      t.string :cng_renewable_source
      t.string :cng_total_compression
      t.string :cng_total_storage
      t.string :cng_vehicle_class
      t.string :e85_blender_pump
      t.string :e85_other_ethanol_blends
      t.string :ev_dc_fast_num
      t.string :ev_level1_evse_num
      t.string :ev_level2_evse_num
      t.string :ev_network
      t.string :ev_network_web
      t.string :ev_other_evse
      t.string :ev_pricing
      t.string :ev_renewable_source
      t.string :hy_is_retail
      t.string :hy_pressures
      t.string :hy_standards
      t.string :hy_status_link
      t.string :lng_renewable_source
      t.string :lng_vehicle_class
      t.string :lpg_primary
      t.string :lpg_nozzle_types
      t.string :ng_fill_type_code
      t.string :ng_psi
      t.string :ng_vehicle_class
      t.string :rd_blends
      t.string :rd_blends_fr
      t.string :rd_blended_with_biodiesel
      t.string :rd_max_biodiesel_level
      t.string :access_days_time_fr
      t.string :intersection_directions_fr
      t.string :bd_blends_fr
      t.string :groups_with_access_code_fr
      t.string :ev_pricing_fr
      t.string :distance
      t.string :distance_km

      t.timestamps
    end
  end
end
