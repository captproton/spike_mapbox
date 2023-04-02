class AddPhone2ToNrelLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :nrel_locations, :phone, :string
  end
end
