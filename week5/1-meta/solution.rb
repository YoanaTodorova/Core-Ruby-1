class String
  def to_proc
    methods = split('.')
    proc do |argument|
      methods.inject(argument) do |result, method|
        result.public_send(method)
      end
    end
  end
end

class NilClass
  def method_missing(*)
    nil
  end
end

class Object
  def singleton_class
    self
  end

  # def define_singleton_method(name, &implementation)
  #   singleton_class.send(:define_method, name, &implementation)
  # end

  def self.delegate(method, to: object)
    self.class_eval do
      define_singleton_method method do
        self.instance_variable_get(object).public_send(method)
      end
    end
  end
end

class Proxy < Object
  def initialize(target)
    @target = target
  end

  def method_missing(name, *args, &block)
    @target.public_send(name, *args, &block)
  end
end