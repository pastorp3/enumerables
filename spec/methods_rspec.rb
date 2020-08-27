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

      def my_all_option1(input, arr)
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
        count
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
      it 'my_all? test with string = true' do
       arr = ['ant' ,'bear' ,'cat']
        expect((arr).my_all? { |word| word.length >= 3 }).to eql(true)
      end
      it 'my_all? test with string = false' do
        arr = ['ant' ,'bear' ,'cat']
         expect((arr).my_all? { |word| word.length >= 4 }).to eql(false)
 
       end
       it 'my_all? test with regex' do
        arr = ['ant' ,'bear' ,'cat']
         expect((arr).my_all?(/t/)).to eql(false)
 
       end
       it 'my_all? test with class' do
        arr = [1, 2i, 3.14]
         expect((arr).my_all?(Numeric)).to eql(true)
 
       end
       it 'my_all? test with nil elements' do
        arr = [nil ,false , 99]
         expect((arr).my_all?).to eql(false)
 
       end
       it 'my_all? test with no elements' do
        arr = []
         expect((arr).my_all?).to eql(true)
 
       end

    end





