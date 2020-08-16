module Enumerable
  def my_each
    return puts to_enum unless block_given?

    i = 0
    arr = to_a
    while i <= arr.length - 1
      yield(arr[i])
      i += 1
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

  def my_select
    return puts to_enum unless block_given?
    arr = to_a
    new_array = []
    arr.my_each do |x|
      new_array << x if yield(x) == true
    end
    return new_array
  end

  def my_all?
    if block_given? == false && ((find { |x| x == false }) == false || (find { |x| x.nil? }).nil?)
      false
    elsif block_given? == false && ((find { |x| x == false }).nil? && (find { |x| x.nil? }).nil?)
      true
    elsif block_given?
      arr = to_a
      count = 0
      arr.my_each do |x|
        count += 1 if yield(x)
      end
      count == arr.length
    end
  end

  def my_any?
    if block_given? == false && (my_all? { |x| x.nil? }) != true && (my_all? { |x| x == false }) != true
      true
    elsif block_given? == false && (my_all? { |x| x.nil? }) != false || (my_all? { |x| x == false }) != false
      false
    elsif block_given?
      arr = to_a
      count = 0
      arr.my_each do |x|
        count += 1 if yield(x)
      end
      count >= 1
    end
  end

  def my_none?
    if block_given? == false && (my_all? { |x| x.nil? }) != false || (my_all? { |x| x == false }) != false
      true
    elsif block_given? == false && (my_all? { |x| x.nil? }) != true && (my_all? { |x| x == false }) != true
      false
    elsif block_given?
      arr = to_a
      count = 0
      arr.my_each do |x|
        count += 1 if yield(x)
      end
      count == 0
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
end

def multiply_else(input)
  input.my_inject { |k, n| k * n }
end

# Test

mult = proc { |x| x * 100 }

[8, 9, 10].my_each_with_index { |num, idx| puts "num is #{num} at index #{idx}" }
p([1, 2, 3, 4, 5]).my_select { |x| x > 3 }
puts ([1, 2, 3, 4]).my_all? { |x| x > 1 }
puts ([nil, 1]).my_any?
puts ([1, 2, 3, 4]).my_any? { |x| x == 1 }
puts (1..50).my_none? { |x| x > 49 }
puts (1..50).my_count { |x| x.even? }
p (1..10).my_map(&mult)
p (1..20).my_inject { |x| x * 2 }
p multiply_else([2, 4, 5])
