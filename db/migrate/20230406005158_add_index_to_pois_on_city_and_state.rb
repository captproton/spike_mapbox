class AddIndexToPoisOnCityAndState < ActiveRecord::Migration[7.0]
  def change
    add_index :pois, [:city, :state]    
  end
end
