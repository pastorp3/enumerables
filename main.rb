module Enumerable

  def my_each
    return puts to_enum unless block_given?
    i = 0
    arr = self.to_a
     while i <= arr.length-1
       yield(arr[i])
       i += 1
     end
 
     
  end


  def my_each_with_index
    return puts to_enum unless block_given?
    i = 0
    arr = self.to_a
    while i <= arr.length - 1
      yield(arr[i], i)
      i += 1
    end
  end

  def my_select
    return puts to_enum unless block_given?
    arr = self.to_a
    new_array = []
    arr.my_each do |x|
      if yield(x) == true
        new_array << x
      end
    end
    print new_array
  end

  def my_all?
    if block_given? == false && ((self.find {|x| x == false }) == false  || (self.find {|x| x == nil }) == nil)
      return false
    elsif block_given? == false && ((self.find {|x| x == false }) == nil &&  (self.find {|x| x == nil }) == nil)
      return true
    elsif block_given? 
      arr = self.to_a
      count = 0
      arr.my_each do |x|
        if yield(x)
          count += 1
        end
      end
      if count == arr.length
        return true
      else return false
      end
    end

   
  end

  def my_any?
    if block_given? == false && (self.my_all? {|x| x == nil }) !=  true && (self.my_all? {|x| x == false}) != true 
      return true
    elsif block_given? == false && (self.my_all? {|x| x == nil }) != false || (self.my_all? {|x| x == false}) != false  
      return false
    elsif block_given?
      arr = self.to_a
      count = 0
      arr.my_each do |x|
        if yield(x)
          count += 1
        end
      end
      if count >= 1
        return true
      else return false
      end
    end
  end

  def my_none?
    if block_given? == false && (self.my_all? {|x| x == nil }) !=  false || (self.my_all? {|x| x == false}) !=  false
      return true
    elsif block_given? == false && (self.my_all? {|x| x == nil }) != true && (self.my_all? {|x| x == false}) != true 
      return false
    elsif block_given?
      arr = self.to_a
      count = 0
      arr.my_each do |x|
        if yield(x)
          count += 1
        end
      end
      if count == 0
        return true
      else return false
      end
    end
  end

  def my_count
    if block_given? == false
      arr = self.to_a
      puts arr.length
    elsif block_given?
      count = 0
      self.my_each do |x| 
        if yield(x)
          count += 1
        end
      end
      return count
    end
  end

  def my_map
    return puts to_enum unless block_given?
    new_array = []
    self.my_each do |x|
      new_value = yield(x)
      new_array << new_value
    end
    return new_array
  end

  def my_inject(*input)
    return LocalJumpError  unless block_given?

    input = input.to_a
    argument = input + self
    return nil if argument.length.zero?
    return argument[0] if argument.length == 1

    output = argument[0]
    argument[1..argument.length - 1].my_each { |num| output = yield(output, num) }
    output
  end
end

def multiply_els(input)
  input.my_inject { |k, n| k * n }
end

# Test

mult = Proc.new {|x| x * 100}

([8, 9, 10]).my_each_with_index { |num, idx| puts "num is #{num} at index #{idx}" }
p([1, 2, 3, 4, 5, 6]).my_select { |x| x.is_a?(Integer) }
p([0, 1, 2, 3, 4, 5, 6]).my_all? { |x| x >= 1 }
p([1, 2, 3, 4, 5, 6, 7]).my_any? { |x| x > 7 }
p([1, 2, 3, 4, 5, 6, 7]).my_none? { |x| x >= 7 }
p([2, 2, 2, 2, 2, 3, 4]).my_count { |x| x == 2 }
p([2, 4, 5]).my_map { |x| x * 2 }
p ([1,2,3]).my_map(&mult)
p([5, 6, 10]).my_inject { |sum, n| sum + n }
p multiply_els([2, 4, 5])

