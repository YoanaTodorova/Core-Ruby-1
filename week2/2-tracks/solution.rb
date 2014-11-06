require 'yaml'

class HashWithIndifferentAccess < Hash
  def [](key)
    super(key.to_sym)
  end

  def []=(key, value)
    super(key.to_sym, value)
  end

  def fetch(key)
    super(key.to_sym)
  end
end

class Hash
  def with_indifferent_access
    HashWithIndifferentAccess.new(self)
  end
end

class Track
  attr_accessor :artist, :name, :album, :genre

  def initialize(*args)
    if args[0].is_a? Hash
      args[0].each { |key,value| public_send("#{key}=".to_sym, value) }
    else
      raise ArgumentError if args.size < 4
      @artist, @name, @album, @genre = args
    end
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
    tracks = YAML.load_file(path).map do |attributes|
      h = Hash.new.with_indifferent_access
      attributes.each { |key, value| h[key] = value }
      Track.new(h)
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