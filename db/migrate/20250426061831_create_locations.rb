class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :latitude
      t.string :longitude
      t.float :speed
      t.datetime :timestamp

      t.timestamps
    end
  end
end
