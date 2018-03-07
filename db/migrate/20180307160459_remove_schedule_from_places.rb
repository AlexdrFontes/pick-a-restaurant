class RemoveScheduleFromPlaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :places, :schedule, :string
  end
end
