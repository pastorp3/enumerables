# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
def my_each
  return to_enum unless block_given?

  i = 0
  arr = to_a
  while i <= arr.length - 1
    yield (arr[i])
    i += 1
  end
  self
end

def my_each_with_index
  return to_enum unless block_given?

  i = 0
  arr = to_a
  while i <= arr.length - 1
    yield(arr[i], i)
    i += 1
  end
  self
end

def all_validate
  arr = self
  if block_given? == false && (arr.include?(false) == true || arr.include?(nil) == true)
    false
  elsif block_given? == false && (arr.include?(false) == false && arr.include?(nil) == false)
    true
  end
end

def my_all?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if arr.all_validate == false
      false
    elsif arr.all_validate == true
      true
    end
  elsif block_given? == false && !input.nil?
    arr = to_a
    count = 0
    arr.my_each do |x|
      if input.is_a?(Integer)
        count += 1 if x == input
      elsif input.is_a?(Regexp)
        count += 1 unless (x =~ input).nil?
      elsif input.is_a?(Class)
        count += 1 if x.is_a?(input)
      end
    end
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
  end
  count == arr.length
end

def any_validate
  nilv = proc { |x| x.nil? }
  arr = self
  if block_given? == false && (arr.my_all?(&nilv) == true || arr.my_all? { |x| x == false } == true)
    false
  elsif block_given? == false && (arr.my_all?(&nilv) == false && arr.my_all? { |x| x == false } == false)
    true
  end
end

def my_any?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if arr.any_validate == false
      false
    elsif arr.any_validate == true
      true
    end
  elsif block_given? == false && !input.nil?
    arr = to_a
    count = 0
    arr.my_each do |x|
      if input.is_a?(Integer)
        count += 1 if x == input
      elsif input.is_a?(Regexp)
        count += 1 unless (x =~ input).nil?
      elsif input.is_a?(Class)
        count += 1 if x.is_a?(input)
      end
    end
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
  end
  count >= 1
end

def my_none?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if arr.any_validate == false
      false
    elsif arr.any_validate == true
      true
    end
  elsif block_given? == false && !input.nil?
    arr = to_a
    count = 0
    arr.my_each do |x|
      if input.is_a?(Integer)
        count += 1 if x == input
      elsif input.is_a?(Regexp)
        count += 1 unless (x =~ input).nil?
      elsif input.is_a?(Class)
        count += 1 if x.is_a?(input)
      end
    end
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
  end
  count.zero?
end

def my_count(input = nil)
  if block_given? == false && input.nil?
    arr = to_a
    arr.length
  elsif block_given? == false && !input.nil?
    arr = to_a
    count = 0
    arr.my_each do |x|
      if input.is_a?(Integer)
        count += 1 if x == input
      else
        count
      end
    end
    count
  elsif block_given? == true
    count = 0
    arr = to_a
    arr.my_each do |x|
      count += 1 if yield(x)
    end
    count
  end
end

def my_map(input = nil)
  return to_enum if block_given? == false && input.nil?

  if block_given? && input.nil?
    new_array = []
    my_each do |x|
      new_value = yield(x)
      new_array << new_value
    end
  elsif block_given? == flase && !input.nil?
    new_array = []
    my_each do |x|
      new_array << input[x] if input.is_a?(Proc)
    end
  end

  new_array
end

def my_inject(initial = nil, input = nil)
  raise LocalJumpError if block_given? == false && input.nil? && initial.nil?

  if block_given? == false && input.nil? && initial.nil? == false
    arr = to_a
    if initial.is_a?(Symbol) && arr.my_all?(Integer)
      if initial == :+
        memo = 0
        arr.each do |x|
          memo += x
        end
      elsif initial == :-
        memo = 0
        arr.each do |x|
          memo -= x
        end
      elsif initial == :*
        memo = 1
        arr.each do |x|
          memo *= x
        end
      elsif initial == :/
       if arr.my_all?(1)
          memo = 1
       else memo = 0
       end
      end
    end
  elsif block_given? == false && initial.nil? == false && input.nil? == false
    arr = to_a
    if initial.is_a?(Integer) && arr.my_all?(Integer) && input.is_a?(Symbol)
      if input == :+
        memo = initial
        arr.each do |x|
          memo += x
        end
      elsif input == :-
        memo = initial
        arr.each do |x|
          memo -= x
        end
      elsif input == :*
        memo = initial
        arr.each do |x|
          memo *= x
        end
      elsif input == :/
        if arr.my_all?(1)
          memo = 1
        else memo = 0
        end
      end
    end
  elsif block_given? == true && initial.nil? == false && input.nil?
    arr = to_a
    if initial.is_a?(Integer) && arr.my_all?(Integer) && input.nil?
      memo = initial
      arr.my_each do |x|
        memo = yield(memo, x)
      end
    elsif initial.is_a?(Integer) && arr.my_all?(String) && input.nil?
      memo = initial
    end
  elsif block_given? == true && initial.nil? && input.nil?
    arr = to_a
    if arr.my_all?(Integer)
      memo = 0
      arr.my_each do |x|
        memo = yield(memo, x)
      end
    elsif arr.my_all?(String)
      memo = []
      arr.my_each do |x|
        memo = yield(memo, x)
      end
    end
  end
  memo
end

def multiply_els(input)
  input.my_inject(1) { |k, n| k * n }
end

public 'my_each'
public 'my_each_with_index'
public 'all_validate'
public 'my_all?'
public 'any_validate'
public 'my_any?'
public 'my_none?'
public 'my_count'
public 'my_map'
public 'my_inject'
public 'my_inject'
public 'multiply_els'

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
