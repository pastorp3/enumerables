# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    arr = to_a
    while i <= arr.length - 1
      yield(arr[i])
      i += 1
    end
  end

  def my_select
    return puts to_enum unless block_given?
    arr = to_a
    new_array = []
    arr.my_each do |x|
      new_array << x if yield(x) == true
    end
    new_array
  end

  def all_validate
    arr = self
    if block_given? == false && (arr.include?(false) == true || arr.include?(nil) == true)
      false
    elsif block_given? == false && (arr.include?(false) == false && arr.include?(nil) == false)
      true
    end
  end

  def my_all?
    arr = to_a
    if block_given? == false
      if arr.all_validate == false
        false
      elsif arr.all_validate == true
        true
      end
    else
      arr = to_a
      count = 0
      arr.my_each do |x|
        count += 1 if yield(x)
      end
      count == arr.length
    end
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

  def my_any?
    arr = to_a
    if block_given? == false
      if arr.any_validate == false
        false
      elsif arr.any_validate == true
        true
      end
    else
      arr = to_a
      count = 0
      arr.my_each do |x|
        count += 1 if yield(x)
      end
      count >= 1
    end
  end

  def my_none?
    arr = to_a
    if block_given? == false
      if arr.any_validate == false
        true
      elsif arr.any_validate == true
        false
      end
    else
      arr = to_a
      count = 0
      arr.my_each do |x|
        count += 1 if yield(x)
      end
      count.zero?
    end
  end

  def my_count
    if block_given? == false
      arr = to_a
      puts arr.length
    elsif block_given?
      count = 0
      my_each do |x|
        count += 1 if yield(x)
      end
      count
    end
  end

  def my_map
    return puts to_enum unless block_given?

    new_array = []
    my_each do |x|
      new_value = yield(x)
      new_array << new_value
    end
    new_array
  end
end

def my_each_with_index
  return puts to_enum unless block_given?

  i = 0
  arr = to_a
  while i <= arr.length - 1
    yield(arr[i], i)
    i += 1
  end
end

def my_inject
  return LocalJumpError unless block_given?

  n = 1
  arr = to_a
  sum = arr[0]
  result = 0
  while n < arr.length
    result = yield(sum, arr[n])
    sum = result
    n += 1
  end
  result
end

def multiply_else(input)
  input.my_inject { |k, n| k * n }
end

public 'my_inject'
public 'my_each_with_index'
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
