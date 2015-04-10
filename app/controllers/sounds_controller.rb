class SoundsController < ApplicationController

  def index
    hottestSongs = Sound.order(download_count: :desc, favoritings_count: :desc, comment_count: :desc, playback_count: :desc)

    # How does length of Title relate to playback count?
    # sortedSounds = Sound.where("title != ''").sort({ |x,y| y.title.length <=> x.title.length }).order(:playback_count)

    @longestTitleSounds = hottestSongs.first(10).sort_by { |v| v.title.length }.reverse

    # Does ellipsing off the end of the title hurt a song?

    # If genre is contained in tag list, does this result in higher favorites?

    # If a song is allowed to be downloaded, does that help? Which genre?
    # 


  end

end
