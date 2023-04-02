class CreatePois < ActiveRecord::Migration[7.0]
  def change
    create_table :pois do |t|
      t.string :name
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :ev_connector_types
      t.string :ev_dc_fast_num
      t.string :ev_network
      t.string :city
      t.string :state
      t.string :street_address
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
