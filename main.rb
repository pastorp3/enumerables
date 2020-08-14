module Enumerable
  def my_each
    return dup unless block_given?

    i = 0
    while i <= length - 1
      yield(self[i])
      i += 1
    end
  end
  [1, 2, 3].my_each { |num| puts num }

  def my_each_with_index
    return dup unless block_given?

    i = 0
    while i <= length - 1
      yield(self[i], i)
      i += 1
    end
  end
  [8, 9, 10].my_each_with_index { |num, idx| puts "num is #{num} at index #{idx}" }

  def my_select
    return dup unless block_given?

    new_array = []
    my_each { |num| new_array << num if yield(num) }
    new_array
  end

  def my_all?
    my_each { |x| return false unless yield(x) }
    true
  end

  def my_any?
    my_each { |x| return true if yield(x) }
    false
  end

  def my_none?
    my_each { |x| return false if yield(x) }
    true
  end

  def my_count
    counter = 0
    my_each { |x| counter += 1 if yield(x) }
    counter
  end

  def my_map
    new_array = []
    my_each do |x|
      new_value = yield(x)
      new_array << new_value
    end
    new_array
  end
end

p [3, 5, 9].my_select { |num| num.even? }
p [0, 1, 2, 3, 4, 5, 6].my_all? { |x| x >= 1 }
p [1, 2, 3, 4, 5, 6, 7].my_any? { |x| x > 7 }
p [1, 2, 3, 4, 5, 6, 7].my_none? { |x| x >= 7 }
p [2, 2, 2, 2, 2, 3, 4].my_count { |x| x == 2 }
p [2, 4, 5].my_map { |x| x * 2 }