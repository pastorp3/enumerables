# ./spec/tictactoe_spec.rb

public
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

 

    def my_all?(input = nil)
        arr = to_a
        if block_given? == false && input.nil? == true
          if block_given? == false && (arr.include?(false) == false && arr.include?(nil) == false)
            true
          else
            false
          end
        elsif block_given? == false && !input.nil?
          count = my_all_option1(input, arr)
          count == arr.length
        elsif block_given? == true
          arr = to_a
          count = 0
          arr.my_each do |x|
            count += 1 if yield(x) == true
          end
          count == arr.length
        end
      end



    describe '#my_each' do 
      it 'test my_each  method' do
      arr = [1,2,3,4]
      expect( (arr).my_each.class).to eql(Enumerator)
      end
      it 'test my_each with block' do 
        arr = [1,2,3,4]
        expect( (arr).my_each {|x| x }).to eql(arr)
      end
    end

    describe'#my_all?' do 
      it 'asdsa' do
       arr = ['ant' ,'bear' ,'cat']
        expect((arr).my_all? { |word| word.length >= 3 }).to eql(true)

        expect((arr).my_all? { |word| word.length >= 4 }).to eql(false)

      end
    end





