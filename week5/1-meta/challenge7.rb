class P < BasicObject
  class << self
    def to_proc
      proc do |e|
        yield e
      end
    end

    def method_missing(name, *args, &block)

    end
  end
end
