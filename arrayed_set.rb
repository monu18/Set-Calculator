# arrayed_set.rb
require './double_set'

# Subclass for handling ArrayedSet
class ArrayedSet < DoubleSet
  def initialize(values = [])
    @values = values.sort
  end

  def add(value)
    @values << value unless @values.include?(value)
    @values.sort!
  end

  def apply_lambda(lambda_expr)
    @values.map! { |v| lambda_expr.call(v) }
  end

  def union(other_set)
    other_set.values.each { |v| add(v) }
  end

  def intersection(other_set)
    @values &= other_set.values
  end

  def clone
    ArrayedSet.new(@values.clone)
  end

  def values
    @values
  end

  def to_s
    @values.join(', ')
  end
end
