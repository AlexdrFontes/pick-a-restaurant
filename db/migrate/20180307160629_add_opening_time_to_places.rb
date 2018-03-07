class AddOpeningTimeToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :opening_time, :string
  end
end
