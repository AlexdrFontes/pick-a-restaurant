class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :locality
      t.integer :average_cost_for_two
      t.string :featured_image
      t.float :user_rating
      t.integer :phone_number
      t.string :cuisine
      t.string :schedule
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
