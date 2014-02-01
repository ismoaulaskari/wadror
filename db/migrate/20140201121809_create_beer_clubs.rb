class CreateBeerClubs < ActiveRecord::Migration
  def change
    create_table :beer_clubs do |t|
      t.string :name
      t.integer :year
      t.string :city

      t.timestamps
    end
  end
end
