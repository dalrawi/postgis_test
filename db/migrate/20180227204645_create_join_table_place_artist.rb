class CreateJoinTablePlaceArtist < ActiveRecord::Migration[5.1]
  def change
    create_join_table :places, :artists do |t|
       t.index [:place_id, :artist_id]
      # t.index [:artist_id, :place_id]
    end
  end
end
