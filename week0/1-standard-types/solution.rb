def histogram(string)
  chars = string.downcase.tr(' ', '').chars
  Hash.new(0).tap { |hsh| chars.each { |char| hsh[char] += 1 } }
end

def prime?(n)
  (2..Math.sqrt(n)).all? { |number| (n % number).nonzero? }
end

def ordinal(n)
  word = n.to_s
  word + case
         when word.end_with?(*( %w(11 12 13))) then 'th'
         when word.end_with?('1') then 'st'
         when word.end_with?('2') then 'nd'
         when word.end_with?('3') then 'rd'
         else 'th'
         end
end

def palindrome?(object)
  word = object.to_s.tr(' ', '').downcase
  word == word.reverse
end

def anagram?(word, other)
  histogram(word) == histogram(other)
end

def remove_prefix(string, pattern)
  string.gsub(/^#{pattern}/, '').lstrip
end

def remove_suffix(string, suffix)
  string.gsub(/#{suffix}$/, '').rstrip
end

def digits(n)
  n.to_s.chars.map(&:to_i)
end

def fizzbuzz(range)
  range.map do |n|
    case
    when (n % 15).zero? then :fizzbuzz
    when (n % 5).zero? then :buzz
    when (n % 3).zero? then :fizz
    else n
    end
  end
end

def count(object)
  Hash.new(0).tap { |hsh| object.each { |obj| hsh[obj] += 1 } }
end

def count_words(*sentences)
  count(sentences.join(' ').split(/[^\w']+/).map(&:downcase))
end