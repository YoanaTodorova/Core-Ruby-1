module SimpleTest
  class TestContainer
    attr_accessor :tests

    def initialize(klass)
      @tests = []
    end
  end
end