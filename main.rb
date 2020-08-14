module Enumerable
    def my_each 
        return self.dup unless block_given? 
        i = 0
        while i <= self.length - 1 
          yield(self[i])
          i += 1
        end
    end
    [1, 2, 3].my_each { |num| puts num }

    def  my_each_with_index 
      return self.dup unless block_given? 
      i = 0
      while i <= self.length - 1 
        yield(self[i], i)
        i += 1
      end
    end
    [8, 9, 10].my_each_with_index { |num, idx| puts "num is #{num} at index #{idx}" }

    def my_select 
      return self.dup unless block_given? 
      new_array = []
      self.my_each {|num| new_array << num if yield(num)}
      new_array
    end

    p [3, 5, 9].my_select { |num| num.even?}