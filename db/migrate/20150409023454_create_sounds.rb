class CreateSounds < ActiveRecord::Migration
  def change
    create_table :sounds do |t|
      t.integer :sc_id
      t.text :title
      t.datetime :created_at
      t.text :permalink_url
      t.text :tags
      t.text :genre
      t.string :license
      t.string :sharing
      t.integer :comment_count
      t.integer :download_count
      t.boolean :downloadable
      t.integer :playback_count
      t.integer :favoritings_count
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
