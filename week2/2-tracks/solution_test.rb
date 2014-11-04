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
    playlist = Playlist.new TRACK
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
end