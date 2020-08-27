# ./spec/methods_rspec.rb

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength

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

def my_any_option(input, arr)
  count = 0
  arr.my_each do |x|
    if input.is_a?(Integer)
      count += 1 if x == input
    elsif input.is_a?(Regexp)
      count += 1 unless (x =~ input).nil?
    elsif input.is_a?(Class)
      count += 1 if x.is_a?(input)
    elsif input.is_a?(String)
      count += 1 if x == input
    end
  end
  count
end

def my_any?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if block_given? == false && (arr.my_all? { |x| x.nil? || x == false }) == false
      true
    else
      false
    end
  elsif block_given? == false && !input.nil?
    count = my_any_option(input, arr)
    count >= 1
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
    count >= 1
  end
end

def my_none_option(input, arr)
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

def my_none?(input = nil)
  arr = to_a
  if block_given? == false && input.nil?
    if block_given? == false && arr.my_all? { |x| x.nil? || x == false } == true
      true
    else
      false
    end
  elsif block_given? == false && !input.nil?
    count = my_none_option(input, arr)
    count.zero?
  elsif block_given? == true
    arr = to_a
    count = 0
    arr.my_each do |x|
      count += 1 if yield(x) == true
    end
    count.zero?
  end
end

def my_count_option(input, arr)
  count = 0
  arr.my_each do |x|
    if input.is_a?(Integer)
      count += 1 if x == input
    else
      count
    end
  end
  count
end

def my_count(input = nil)
  if block_given? == false && input.nil?
    arr = to_a
    arr.length
  elsif block_given? == false && !input.nil?
    arr = to_a
    count = my_count_option(input, arr)
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
  elsif block_given? == false && !input.nil?
    new_array = []
    my_each do |x|
      new_array << input[x] if input.is_a?(Proc)
    end
  elsif block_given? == true && input.is_a?(Proc)
    new_array = []
    my_each do |x|
      new_array << input[x] if input.is_a?(Proc)
    end
  end

  new_array
end

def my_inject_option1(initial, arr)
  if initial.is_a?(Symbol) && arr.my_all?(Integer)
    if initial == :+
      memo = 0
      arr.each { |x| memo += x }
    elsif initial == :-
      memo = arr[0]
      n = arr.length
      i = 1
      (n - 1).times do
        memo -= arr[i]
        i += 1
      end
    elsif initial == :*
      memo = 1
      arr.each { |x| memo *= x }
    elsif initial == :/
      memo = arr[0]
      n = arr.length
      i = 1
      (n - 1).times do
        memo /= arr[i]
        i += 1
      end
    end
  end
  memo
end

def my_inject_option2(initial, input, arr)
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
    memo = initial
    arr.each do |x|
      memo /= x
    end
  end
  memo
end

def my_inject(initial = nil, input = nil)
  raise LocalJumpError if block_given? == false && input.nil? && initial.nil?

  if block_given? == false && input.nil? && initial.nil? == false
    arr = to_a
    memo = my_inject_option1(initial, arr)
    memo
  elsif block_given? == false && initial.nil? == false && input.nil? == false
    arr = to_a
    if initial.is_a?(Integer) && arr.my_all?(Integer) && input.is_a?(Symbol)
      memo = my_inject_option2(initial, input, arr)
      memo
    end
  elsif block_given? == true && initial.nil? == false && input.nil?
    arr = to_a
    if initial.is_a?(Integer) && arr.my_all?(Integer) && input.nil?
      memo = initial
      arr.my_each { |x| memo = yield(memo, x) }
      memo
    elsif initial.is_a?(Integer) && arr.my_all?(String) && input.nil?
      memo = initial
      memo
    end
  elsif block_given? == true && initial.nil? && input.nil?
    arr = to_a
    if arr.my_all?(Integer)
      memo = arr[0]
      n = arr.length
      i = 1
      (n - 1).times do
        memo = yield(memo, arr[i])
        i += 1
      end
      memo
    elsif arr.my_all?(String)
      memo = []
      arr.my_each { |x| memo = yield(memo, x) }
      memo
    end
  end
end

def multiply_els(input)
  input.my_inject(1) { |k, n| k * n }
end

def my_select
  return to_enum unless block_given?

  arr = to_a
  new_array = []
  arr.my_each do |x|
    new_array << x if yield(x) == true
  end
  new_array
end

# TEST

describe '#my_each' do
  it 'test my_each  method' do
    arr = [1, 2, 3, 4]
    expect(arr.my_each.class).to eql(Enumerator)
  end
  it 'test my_each with block' do
    arr = [1, 2, 3, 4]
    expect(arr.my_each { |x| x }).to eql(arr)
  end
end

describe '#my_each_with_index' do
  it 'eadasd' do
    arr = %w[cat dog wombat]
    # expect((arr).my_each_with_index { |item, index| hash[item] = index }).to eql({"cat"=>0, "dog"=>1, "wombat"=>2})
  end
end

describe '#my_all?' do
  it 'my_all? test with string = true' do
    arr = %w[ant bear cat]
    expect(arr.my_all? { |word| word.length >= 3 }).to eql(true)
  end
  it 'my_all? test with string = false' do
    arr = %w[ant bear cat]
    expect(arr.my_all? { |word| word.length >= 4 }).to eql(false)
  end
  it 'my_all? test with regex' do
    arr = %w[ant bear cat]
    expect(arr.my_all?(/t/)).to eql(false)
  end
  it 'my_all? test with class' do
    arr = [1, 2i, 3.14]
    expect(arr.my_all?(Numeric)).to eql(true)
  end
  it 'my_all? test with nil elements' do
    arr = [nil, false, 99]
    expect(arr.my_all?).to eql(false)
  end
  it 'my_all? test with no elements' do
    arr = []
    expect(arr.my_all?).to eql(true)
  end
end

describe '#my_any?' do
  it 'my_any? test with string = true' do
    arr = %w[ant bear cat]
    expect(arr.my_any? { |word| word.length >= 3 }).to eql(true)
  end
  it 'my_any? test with string = true' do
    arr = %w[ant bear cat]
    expect(arr.my_any? { |word| word.length >= 4 }).to eql(true)
  end
  it 'my_any? test with regex' do
    arr = %w[ant bear cat]
    expect(arr.my_any?(/d/)).to eql(false)
  end
  it 'my_any? test with class' do
    arr = [nil, false, 99]
    expect(arr.my_any?(Integer)).to eql(true)
  end
  it 'my_any? test with nil elements' do
    arr = [nil, false, 99]
    expect(arr.my_any?).to eql(true)
  end
  it 'my_any? test with no elements' do
    arr = []
    expect(arr.my_any?).to eql(false)
  end
end

describe '#my_none?' do
  it 'my_none? test with string = true' do
    arr = %w[ant bear cat]
    expect(arr.my_none? { |word| word.length >= 5 }).to eql(true)
  end
  it 'my_none? test with string = false' do
    arr = %w[ant bear cat]
    expect(arr.my_none? { |word| word.length >= 4 }).to eql(false)
  end
  it 'my_any? test with regex' do
    arr = %w[ant bear cat]
    expect(arr.my_none?(/d/)).to eql(true)
  end

  it 'my_none? with float' do
    arr = [1, 3.14, 42]
    expect(arr.my_none?(Float)).to eql(false)
  end

  it 'my_none? with no elements' do
    arr = []
    expect(arr.my_none?).to eql(true)
  end
  it 'my_none? with nil' do
    arr = [nil]
    expect(arr.my_none?).to eql(true)
  end

  it 'my_none? with nil and false' do
    arr = [nil, false]
    expect(arr.my_none?).to eql(true)
  end
  it 'my_any? test with nil elements' do
    arr = [nil, false, true]
    expect(arr.my_none?).to eql(false)
  end
end

describe '#my_count' do
  it 'my_count without block' do
    arr = [1, 2, 4, 2]
    expect(arr.my_count).to eql(4)
  end

  it 'my_count with argument' do
    arr = [1, 2, 4, 2]
    expect(arr.my_count(2)).to eql(2)
  end
  it 'my_count with block' do
    arr = [1, 2, 4, 2]
    expect(arr.my_count { |x| x.even? }).to eql(3)
  end
end

describe '#my_map' do
  it 'my_map with block' do
    range = (1..4)
    expect(range.my_map { |i| i * i }).to eql([1, 4, 9, 16])
  end
  it 'my_map with no block given' do
    range = (1..4)
    expect(range.my_map.class).to eql(Enumerator)
  end
end

describe '#my_inject' do
  it 'my_inject with block given' do
    range = (5..10)
    expect(range.my_inject { |sum, n| sum + n }).to eql(45)
  end
  it 'my_inject with argument and symbol given' do
    range = (5..10)
    expect(range.my_inject(1, :*)).to eql(151_200)
  end
  it 'my_inject with argument and block' do
    range = (5..10)
    expect(range.my_inject(1) { |product, n| product * n }).to eql(151_200)
  end
  it 'my_inject with string' do
    range = %w[cat sheep bear]
    expect(range.my_inject do |memo, word|
             memo.length > word.length ? memo : word
           end).to eql('sheep')
  end
end

describe '#multiply_els' do
  it 'test multiply_els' do
    expect(multiply_els([2, 4, 5])).to eql(40)
  end
end

describe '#my_select' do
  it 'my_select with block given' do
    arr = [1, 2, 3, 4, 5]
    expect(arr.my_select { |num| num.even? }).to eql([2, 4])
  end
  it 'my_select with no block given' do
    arr = [1, 2, 3, 4, 5]
    expect(arr.my_select.class).to eql(Enumerator)
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity