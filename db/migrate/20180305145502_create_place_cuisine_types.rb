class CreatePlaceCuisineTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :place_cuisine_types do |t|
      t.references :cuisine_type, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
