class AddPostalCodeToPoi < ActiveRecord::Migration[7.0]
  def change
    add_column :pois, :postal_code, :string
  end
end
