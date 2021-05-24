# frozen_string_literal: true

require 'minitest/autorun'

class Node # :nodoc:
  attr_accessor :val, :left, :right

  def initialize(val, left = nil, right = nil)
    @val = val
    @left = left
    @right = right
  end

  def ==(other)
    val == other.val && left == other.left && right == other.right
  end
end

def serialize(node)
  return 'x' if node.nil?

  "#{node.val}:#{serialize(node.left)}:#{serialize(node.right)}"
end

def deserialize(string)
  node_values = string.split(':')

  deserialize_helper(node_values)
end

def deserialize_helper(nodes_values_array)
  node_value = nodes_values_array.shift
  return if node_value == 'x' || node_value.nil?

  node = Node.new(node_value)
  node.left = deserialize_helper(nodes_values_array)
  node.right = deserialize_helper(nodes_values_array)
  node
end

describe '#serialize' do
  it do
    node = Node.new('root')
    _(serialize(node)).must_equal('root:x:x')
  end

  it do
    node = Node.new('root', Node.new('left'), Node.new('right'))
    _(serialize(node)).must_equal('root:left:x:x:right:x:x')
  end

  it do
    node = Node.new('root', Node.new('left', Node.new('left.left')), Node.new('right'))
    _(serialize(node)).must_equal('root:left:left.left:x:x:x:right:x:x')
  end
end

describe '#deserialize' do
  it do
    string = 'root:x:x'
    _(deserialize(string)).must_equal(Node.new('root'))
  end

  it do
    string = 'root:a:ac:x:x:x:b:d:x:x:x'
    node = Node.new(
      'root',
      Node.new(
        'a',
        Node.new('ac')
      ),
      Node.new(
        'b',
        Node.new('d')
      )
    )
    _(deserialize(string)).must_equal(node)
  end

  it do
    node = Node.new(
      'root',
      Node.new(
        'left',
        Node.new('left.left')
      ),
      Node.new('right')
    )
    _(deserialize(serialize(node)).left.left.val).must_equal('left.left')
  end
end
