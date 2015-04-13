desc "Grab data from soundcloud"
task :populate_from_soundcloud => :environment do

  # This isn't exactly the best option for record keeping over time, but I'm keeping this thing free for now, and I don't want to pay for Heroku's DB service for now.
  Sound.destroy_all

  print "Setting up client..."
  client = SoundCloud.new(:client_id => ENV['SOUND_CLOUD_CLIENT_ID'])
  print "DONE\n"

  genres = ["popular", "ambient", "electronic", "hiphop", "rap", "reggaeton", "rock", "country", "mashup", "classical", "alternative"]

  # Prime the variable to stuff tracks into
  tracks = client.get('/tracks', :limit => 1, :offset => 0, :q => "alternative", :linked_partitioning => 1)

  genres.each do |genre|
    print "Getting #{genre} tracks..."
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 0, :q => genre, :linked_partitioning => 1).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 200, :q => genre, :linked_partitioning => 2).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 400, :q => genre, :linked_partitioning => 3).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 600, :q => genre, :linked_partitioning => 4).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 800, :q => genre, :linked_partitioning => 5).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1000, :q => genre, :linked_partitioning => 6).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1200, :q => genre, :linked_partitioning => 7).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1400, :q => genre, :linked_partitioning => 8).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1600, :q => genre, :linked_partitioning => 9).collection
    # tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1800, :q => genre, :linked_partitioning => 10).collection
    print "DONE (TRACK COUNT: #{tracks.collection.count})\n"
  end

  print "Saving tracks to database..."
  if Rails.env.development? then print "\\" end
  tracks.collection.each do |track|
    # We only want tracks (protection again user or other types) that are interesting
    if track.kind == "track" and track.download_count and track.download_count > 0 and track.favoritings_count and track.favoritings_count > 0 and track.comment_count and track.comment_count > 0 and track.playback_count and track.playback_count > 0
      if Rails.env.development? then print "\\b|" end
      if Rails.env.development? then print "\\b/" end
      sound = Sound.new :sc_id => track.id, :title => track.title, :created_at => track.created_at, :permalink_url => track.permalink_url, :tags => track.tag_list, :genre => track.genre, :license => track.license, :sharing => track.sharing, :comment_count => track.comment_count, :download_count => track.download_count, :downloadable => track.downloadable, :playback_count => track.playback_count, :favoritings_count => track.favoritings_count
      if Rails.env.development? then print "\\b-" end
      sound.save
      if Rails.env.development? then print "\\b\\" end
    end
  end
  print "DONE\n"
end