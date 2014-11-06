require 'minitest/autorun'

require_relative 'solution'

class SolutionTest < Minitest::Test
  TRACK = Track.new("KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance")
  
  def test_initialize
    assert_raises(ArgumentError) { Track.new }
    assert_raises(ArgumentError) { Track.new("KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad") }
  end

  def test_accessors
    assert_equal "KAYTRANADA feat. Shay Lia", TRACK.artist
    assert_equal "Leave me alone", TRACK.name
    assert_equal "So Bad", TRACK.album
    assert_equal "Dance", TRACK.genre
  end

  def test_playlist_find_by
    track = Track.new "Led Zeppellin", "Leave me alone", "So Bad", "Dance"
    track1 = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"
    playlist = Playlist.new(track, track1)

    filter1 = proc { |track| track.artist == 'Led Zeppellin' }
    filter2 = proc { |track| track.genre == 'Dance' }

    assert_equal Playlist.new(track), playlist.find_by(filter1, filter2)
  end

  def test_playlist_minus
    track = Track.new "Led Zeppellin", "Leave me alone", "So Bad", "Dance"
    track1 = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"
    playlist = Playlist.new(track, track1)
    playlist1 = Playlist.new(track)

    assert_equal Playlist.new(track1), playlist - playlist1
  end

  def test_playlist_and
    track = Track.new "Led Zeppellin", "Leave me alone", "So Bad", "Dance"
    track1 = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"
    playlist = Playlist.new(track, track1)
    playlist1 = Playlist.new(track)

    assert_equal Playlist.new(track), playlist & playlist1
  end

  def test_from_yaml
    track1 = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"
    track3 = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"
    track2 = Track.new 'Iron Maiden', 'The number of the beast', 'The number of the beast', 'heavy metal'
    playlist = Playlist.new(track1, track2)

    assert_equal track1, track3
    assert_equal Playlist.new(track1, track2), Playlist.new(track1, track2)
    assert_equal playlist, Playlist.from_yaml('./sample.yml')
  end

  def test_to_s
    track1 = Track.new "KAYTRANADA feat. Shay Lia", "Leave me alone", "So Bad", "Dance"
    track2 = Track.new 'Iron Maiden', 'The number of the beast', 'The number of the beast', 'heavy metal'
    playlist = Playlist.new(track1, track2)
    
    puts
    puts playlist
  end
end