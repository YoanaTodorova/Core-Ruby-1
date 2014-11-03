class Hash
  def pick(*keys)
    select { |key,value| keys.include? key }
  end

  def pick!(*keys)
    select! { |key,value| keys.include? key }
  end

  def except(*keys)
    reject { |key,value| keys.include? key }
  end

  def except!(*keys)
    reject! { |key,value| keys.include? key }
  end

  def values_map(&block)
    Hash[keys.zip(values.map(&block))]
  end

  def values_map!(&block)
    merge! Hash[keys.zip(values.map(&block))]
  end

  def compact_values
    reject { |key,value| !!value == false }
  end

  def compact_values!
    reject! { |key,value| !!value == false }
  end

  def defaults(hash)
    merge(hash) { |key, oldval, newval| oldval }
  end

  def defaults!(hash)
    merge!(hash) { |key, oldval, newval| oldval }
  end
end