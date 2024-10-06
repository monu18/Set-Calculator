# Superclass for managing two sets: X and Y
class DoubleSet
  def initialize
    @set_x = nil
    @set_y = nil
  end

  def set_x(values, type)
    @set_x = type == :tree ? BranchingSet.new(values) : ArrayedSet.new(values)
  end

  def set_y(values)
    @set_y = ArrayedSet.new(values)
  end

  # Apply lambda to each element of X
  def apply_lambda(lambda_expr)
    @set_x.apply_lambda(lambda_expr)
  end

  # Add a number to set X
  def add_to_x(value)
    @set_x.add(value)
  end

  # Perform set union
  def union
    @set_x.union(@set_y)
  end

  # Perform set intersection
  def intersection
    @set_x.intersection(@set_y)
  end

  # Swap X and Y
  def swap
    @set_x, @set_y = @set_y, @set_x
  end

  # Copy X into Y
  def copy_x_to_y
    @set_y = @set_x.clone
  end

  # List content of both sets using the [] operator in subclasses
  def list_sets
    puts "Set X: #{@set_x.values.join(', ')}"
    puts "Set Y: #{@set_y.values.join(', ')}"
  end

  # Implement exit operation
  def quit
    list_sets
    puts "Exiting Set Calculator"
    exit
  end
end