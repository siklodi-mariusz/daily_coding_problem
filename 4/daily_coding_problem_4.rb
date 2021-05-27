# frozen_string_literal: true

require 'minitest/autorun'

def low_integer(nums)
  nums_lenght = nums.length

  0.upto(nums_lenght - 1).each do |i|
    n = nums[i]
    next if n == i + 1

    while n >= 1 && n <= nums_lenght && nums[n -1] != nums[i]
      nums[n - 1], nums[i] = nums[i], nums[n - 1]
      n = nums[i]
    end
  end


  num = nums_lenght + 1
  nums.each.with_index do |n, i|
    idx = i + 1
    break num = idx if n != idx
  end
  num
end

describe '#low_integer' do
  it { _(low_integer([])).must_equal(1) }
  it { _(low_integer([0])).must_equal(1) }
  it { _(low_integer([1])).must_equal(2) }
  it { _(low_integer([1, 2, 0])).must_equal(3) }
  it { _(low_integer([3, 4, -1, 1])).must_equal(2) }
  it { _(low_integer([7, 8, 9, 11, 12])).must_equal(1) }
  it { _(low_integer([7, 8, 9, 11, 12])).must_equal(1) }
  it { _(low_integer([1, 1, 1, 1, 1, 1])).must_equal(2) }
  it { _(low_integer([1, 1, 1, 1, 1, 7])).must_equal(2) }
  it { _(low_integer([-3, -2, 0, -5, -4, -1])).must_equal(1) }  
  it { _(low_integer([4, 6, 5, 3, 1, 8, 9, 7, 2])).must_equal(10) }
end
