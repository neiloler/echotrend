class SoundsController < ApplicationController

  def index
    sort_order = "download_count, favoritings_count, comment_count, playback_count"


    # How does length of Title relate to playback count?
    sortedSounds = Sound.where("title != ''").sort { |x,y| y.title.length <=> x.title.length }
    @longestTitleSounds = sortedSounds.first(100)
    @shortestTitleSounds = sortedSounds.last(100)

    # Does ellipsing off the end of the title hurt a song?

    # If genre is contained in tag list, does this result in higher favorites
    #   Get songs that have genre/tag matches, sort by sort_order


    #   Get top ten songs (maybe get bottom 10 as well?)
    # stuff.first(10)

    # If a song is allowed to be downloaded, does that help? Which genre?
    # 


  end

end
