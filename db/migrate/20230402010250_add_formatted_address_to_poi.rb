class AddFormattedAddressToPoi < ActiveRecord::Migration[7.0]
  def change
    add_column :pois, :formatted_address, :string
  end
end
