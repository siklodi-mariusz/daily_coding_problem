# frozen_string_literal: true

require 'minitest/autorun'

def sum_of_two(numbers, sum)
  return false if numbers.size < 2

  result = []
  numbers.each_with_object({}) do |n, obj|
    n2 = sum - n
    break result = [n, obj[n]] if obj[n]

    obj[n2] = n
  end
  p "result: #{result}, sum: #{sum}"
  result.any?
end

describe '#sum_of_two' do
  # Positive results
  it { _(sum_of_two([100, 25, 6, 7], 106)).must_equal(true) }
  it { _(sum_of_two([10, 15, 3, 7], 17)).must_equal(true) }
  it { _(sum_of_two((1..10_000).to_a.shuffle, 5164)).must_equal(true) }
  it { _(sum_of_two((-1_000..1_000).to_a.shuffle, 432)).must_equal(true) }
  it { _(sum_of_two([-10, 0, 3, 2, 5, 8], 7)).must_equal(true) }
  it { _(sum_of_two([-20, 0, 3, 20, 5, 8], 0)).must_equal(true) }

  # Negative results
  it { _(sum_of_two([1, 2, 3, 7], 25)).must_equal(false) }
  it { _(sum_of_two([1], 25)).must_equal(false) }
  it { _(sum_of_two([1, 100], 12)).must_equal(false) }
  it { _(sum_of_two([-10, 1, 5, -6, 7], 0)).must_equal(false) }
  it { _(sum_of_two([1], 25)).must_equal(false) }
end
