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
  def define_singleton_method(name, &implementation)
    singleton_class.send(:define_method, name, &implementation)
  end
end