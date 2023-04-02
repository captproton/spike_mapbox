class AddHoursToNrelLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :nrel_locations, :hours, :string
  end
end
