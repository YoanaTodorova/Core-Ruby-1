module SimpleTest
    require 'test_container'

  class Test
    require 'assertions'
    include SimpleTest::Assertions

    @@tests = []

    def self.inherited(klass)
      @@tests << klass
    end

    def self.test(name, &block)
      @name = name
      block.call
    end

    def self.xtest
      # skips test

    end

    def self.setup(&block)
      # before every test

    end

    def self.teardown(&block)
      # after evey test

    end
  end
end



class A
  def self.inherited(klass)
    @@a = 1
  end

  def self.a
    @@a
  end
end


class B < A
end