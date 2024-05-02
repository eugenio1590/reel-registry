class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.date :release_at
      t.string :director
      t.string :genre
      t.text :synopsis
      t.integer :duration

      t.timestamps
    end
  end
end
