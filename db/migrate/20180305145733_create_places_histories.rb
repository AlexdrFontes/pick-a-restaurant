class CreatePlacesHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :places_histories do |t|
      t.boolean :rejected
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
