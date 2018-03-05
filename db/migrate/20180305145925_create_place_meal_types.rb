class CreatePlaceMealTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :place_meal_types do |t|
      t.references :place, foreign_key: true
      t.references :meal_type, foreign_key: true

      t.timestamps
    end
  end
end
