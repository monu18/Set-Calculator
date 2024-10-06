require './DoubleSet'

# Subclass for handling ArrayedSet, storing elements in a sorted array
class ArrayedSet < DoubleSet
  # Initializes the ArrayedSet with sorted values, or an empty set if none provided
  def initialize(values = [])
    @values = values.sort
  end

  # Adds a value to the set if it's not already present, maintaining sorted order
  def add(value)
    @values << value unless @values.include?(value)  # Add if not present
    @values.sort!  # Keep sorted
  end

  # Applies a lambda to each element in the set
  def apply_lambda(lambda_expr)
    @values.map! { |v| lambda_expr.call(v) }  # Update values
  end

  # Combines the current set with another set through union
  def union(other_set)
    other_set.values.each { |v| add(v) }  # Add unique values from other_set
  end

  # Updates the current set to contain only elements in the intersection with other_set
  def intersection(other_set)
    @values &= other_set.values  # Retain common elements
  end

  # Returns a clone of the current ArrayedSet
  def clone
    ArrayedSet.new(@values.clone)  # New instance with cloned values
  end

  # Retrieves the values stored in the set
  def values
    @values  # Return internal values
  end

  # Converts the set to a string representation
  def to_s
    @values.join(', ')  # String format of the set
  end

  # Allows indexed access to the values
  def [](index)
    @values[index]  # Fetch element at index
  end
end
