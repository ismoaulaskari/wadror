class AddBeerClubForeignKeyToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :beer_club_id, :integer
  end
end
