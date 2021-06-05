# frozen_string_literal: true

require 'minitest/autorun'

def cons(a, b)
  proc { |f| f.call(a, b) }
end

def car(pair)
  f = proc { |a, b| [a, b] }
  pair.call(f)[0]
end

def cdr(pair)
  f = proc { |a, b| [a, b] }
  pair.call(f)[1]
end

describe '#car' do
  it { _(car(cons(1, 2))).must_equal(1) }
  it { _(car(cons(3, 4))).must_equal(3) }
  it { _(car(cons(nil, 1))).must_equal(nil) }
end

describe '#cdr' do
  it { _(cdr(cons(1, 2))).must_equal(2) }
  it { _(cdr(cons(3, 4))).must_equal(4) }
  it { _(cdr(cons(nil, 1))).must_equal(1) }  
end
