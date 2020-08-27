# ./spec/methods_spec.rb

# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
# rubocop:disable Style/SymbolProc

require_relative '../main'

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
    arr = [11, 22, 31, 224, 44]
    expect(arr.my_each_with_index do |val, index|
             puts "index: #{index} for #{val}" if val < 30
           end).to eql([11, 22, 31, 224, 44])
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
# rubocop:enable Style/SymbolProc
