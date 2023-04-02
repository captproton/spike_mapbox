class AddPhoneToNrelLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :nrel_locations, :name, :string
  end
end
