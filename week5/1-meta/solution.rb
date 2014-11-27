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