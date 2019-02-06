module SimpleTest
  module Assertions
    def assert(actual)
      @assertions += 1
      result = !!actual
      @failures += 1 unless result
      result
    end

    def assert_not(expected, actual)
      @assertions += 1
    end

    def assert_equal(expected, actual)
      @assertions += 1
    end

    def assert_true(actual)
      @assertions += 1

    end

    def assert_false(actual)
      @assertions += 1

    end

    def assert_nil(actual)
      @assertions += 1

    end
  end
end