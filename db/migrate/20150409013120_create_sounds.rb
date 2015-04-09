class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.integer :sc_id
      t.text :title
      t.date :created_at
      t.text :permalink_url
      t.text :tags
      t.text :genre
      t.string :license
      t.integer :comment_count
      t.integer :download_count
      t.integer :playback_count
      t.integer :favoritings_count

      t.timestamps null: false
    end
  end
end
