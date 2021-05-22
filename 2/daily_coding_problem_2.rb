# frozen_string_literal: true

require 'minitest/autorun'

# First attemp using division
def product_without_i(numbers)
  return numbers if numbers.empty?

  total = numbers.reduce(:*)

  numbers.map do |n|
    total / n
  end
end

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def product_without_i_no_division(numbers)
  return numbers if numbers.empty?

  last_index = numbers.length - 1
  left = Array.new(numbers.length, 1)
  output = Array.new(numbers.length, 1)
  right = 1

  1.upto(last_index).each do |i|
    left[i] = numbers[i - 1] * left[i - 1]
  end

  (last_index).downto(0).each do |i|
    output[i] = left[i] * right
    right *= numbers[i]
  end

  output
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

describe '#product_without_i' do
  it { _(product_without_i([])).must_equal([]) }
  it { _(product_without_i([1, 2, 3, 4, 5])).must_equal([120, 60, 40, 30, 24]) }
  it { _(product_without_i([3, 2, 1])).must_equal([2, 3, 6]) }

  it { _(product_without_i_no_division([])).must_equal([]) }
  it { _(product_without_i_no_division([1, 2, 3, 4, 5])).must_equal([120, 60, 40, 30, 24]) }
  it { _(product_without_i_no_division([3, 2, 1])).must_equal([2, 3, 6]) }
end
