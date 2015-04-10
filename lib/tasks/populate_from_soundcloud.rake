desc "Grab data from soundcloud"
task :populate_from_soundcloud => :environment do

  print "Setting up client..."
  client = SoundCloud.new(:client_id => Rails.application.secrets.SOUND_CLOUD_CLIENT_ID)
  print "DONE\n"

  genres = ["popular", "ambient", "electronic", "hiphop", "rap", "reggaeton", "rock", "country", "mashup", "classical", "alternative"]

  # Prime the variable to stuff tracks into
  tracks = client.get('/tracks', :limit => 1, :offset => 0, :q => "alternative", :linked_partitioning => 1)

  genres.each do |genre|
    print "Getting #{genre} tracks..."
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 0, :q => genre, :linked_partitioning => 1).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 200, :q => genre, :linked_partitioning => 2).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 400, :q => genre, :linked_partitioning => 3).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 600, :q => genre, :linked_partitioning => 4).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 800, :q => genre, :linked_partitioning => 5).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1000, :q => genre, :linked_partitioning => 6).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1200, :q => genre, :linked_partitioning => 7).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1400, :q => genre, :linked_partitioning => 8).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1600, :q => genre, :linked_partitioning => 9).collection
    tracks.collection.concat client.get('/tracks', :limit => 200, :offset => 1800, :q => genre, :linked_partitioning => 10).collection
    print "DONE (TRACK COUNT: #{tracks.collection.count})\n"
  end

  print "Saving tracks to database...\\"
  tracks.collection.each do |track|
    if track.kind == "track" # This check could unneccessary, but I don't trust the API data completely at this point
      print "\\b|"
      print "\\b/"
      sound = Sound.new :sc_id => track.id, :title => track.title, :created_at => track.created_at, :permalink_url => track.permalink_url, :tags => track.tag_list, :genre => track.genre, :license => track.license, :sharing => track.sharing, :comment_count => track.comment_count, :download_count => track.download_count, :downloadable => track.downloadable, :playback_count => track.playback_count, :favoritings_count => track.favoritings_count
      print "\\b-"
      sound.save
      print "\\b\\"
    end
  end
  print "DONE\n"
end