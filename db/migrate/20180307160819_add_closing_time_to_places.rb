class AddClosingTimeToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :closing_time, :string
  end
end
