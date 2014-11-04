class Track
  attr_accessor :artist, :name, :album, :genre

  # TODO: make it possible to pass artist: ...
  def initialize(*args)
    raise ArgumentError if args.size < 4
    @artist, @name, @album, @genre = args
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
    # Your code goes here.
  end

  def find
    Playlist.new @tracks.select { |track| yield track }
  end

  def find_by(*filters)
    # Filter is any object that responds to the method #call. #call accepts one
    # argument, the track it should match or not match.
    #
    # Should return a new Playlist.
    Playlist.new @tracks.select 
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
    # It should return a nice tabular representation of all the tracks.
    # Checkout the String class for something that can help you with that.
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
    @tracks == playlist.each.to_a
  end

  private

  def find_by_attribute(attribute, value)
    Playlist.new @tracks.filter { |track| track.send(attribute) == value }
  end
end