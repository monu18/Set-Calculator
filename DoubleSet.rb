# Superclass for managing two sets: X and Y
class DoubleSet
  # Initializes the DoubleSet with empty sets for X and Y.
  def initialize
    @set_x = nil
    @set_y = nil
  end

  # Sets the values for set X, creating either a BranchingSet (BST) or ArrayedSet based on the provided type.
  def set_x(values, type)
    @set_x = type == :tree ? BranchingSet.new(values) : ArrayedSet.new(values)
  end

  # Sets the values for set Y as an ArrayedSet.
  def set_y(values)
    @set_y = ArrayedSet.new(values)
  end

  # Applies a lambda expression to each element in set X.
  def apply_lambda(lambda_expr)
    @set_x.apply_lambda(lambda_expr)
  end

  # Adds a value to set X.
  def add_to_x(value)
    @set_x.add(value)
  end

  # Performs a union operation between set X and set Y.
  def union
    @set_x.union(@set_y)
  end

  # Performs an intersection operation between set X and set Y.
  def intersection
    @set_x.intersection(@set_y)
  end

  # Swaps the contents of set X and set Y.
  def swap
    @set_x, @set_y = @set_y, @set_x
  end

  # Copies the contents of set X into set Y.
  def copy_x_to_y
    @set_y = @set_x.clone
  end

  # Lists the contents of both sets, utilizing the [] operator defined in subclasses.
  def list_sets
    puts "Set X: #{@set_x.values.join(', ')}"  # Display elements of set X
    puts "Set Y: #{@set_y.values.join(', ')}"  # Display elements of set Y
  end

  # Implements the exit operation, displaying current set contents and exiting the program.
  def quit
    list_sets
    puts "Exiting Set Calculator"
    exit
  end
end
