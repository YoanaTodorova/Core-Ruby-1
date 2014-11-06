require 'yaml'

class Track
  attr_accessor :artist, :name, :album, :genre

  # TODO: make it possible to pass artist: ...
  def initialize(*args)
    raise ArgumentError if args.size < 4
    @artist, @name, @album, @genre = args
  end

  def ==(other)
    @artist == other.artist &&
    @name   == other.name   &&
    @album  == other.album  &&
    @genre  == other.genre
  end
end

class Playlist
  def initialize(*tracks)
    @tracks = tracks.flatten
  end

  def each(&block)
    return to_enum(:each) unless block_given?
    @tracks.each(&block)
  end

  def self.from_yaml(path)
    tracks = YAML.load_file(path).map(&:values).map do |values|
      Track.new(*values)
    end
    Playlist.new tracks
  end

  def find
    Playlist.new @tracks.select { |track| yield track }
  end

  def find_by(*filters)
    tracks = @tracks.select do |track|
      filters.all? { |filter| filter.call(track) }
    end
    Playlist.new tracks
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
  end

  def find_by_artist(artist)
    find_by_attribute(:artist, artist)
  end

  def find_by_album(album)
    find_by_attribute(:album, album)
  end

  def find_by_genre(genre)
    find_by_attribute(:genre, genre)
  end

  def shuffle
    Playlist.new @tracks.shuffle
  end

  def random
    @tracks.sample
  end

  def to_s
    @tracks.map do |track|
      [:artist, :name, :album, :genre].map do |attribute|
        "#{track.public_send(attribute).ljust(30)}"
      end.join ''
    end.join "\n"
  end

  def &(playlist)
    Playlist.new @tracks & playlist.each.to_a
  end

  def |(playlist)
    Playlist.new @tracks | playlist.each.to_a
  end

  def -(playlist)
    Playlist.new @tracks - playlist.each.to_a
  end

  def ==(playlist)
    index = 0
    playlist.each do |track|
      return false if track != @tracks[index]
      index += 1
    end
    true
  end

  private

  def find_by_attribute(attribute, value)
    Playlist.new @tracks.filter { |track| track.public_send(attribute) == value }
  end
end