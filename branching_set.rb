require './double_set'

# Subclass for handling a Binary Search Tree (BranchingSet)
class BranchingSet < DoubleSet
  attr_accessor :root  # The root node of the BST

  # Initializes the BST, adding initial values
  def initialize(values = [])
    @root = nil
    values.each { |v| add(v) }  # Add each value to the tree
  end

  # Adds a value to the BST
  def add(value)
    @root = insert(@root, value)  # Insert value into the tree
  end

  # Applies a lambda expression to each value in the BST
  def apply_lambda(lambda_expr)
    traverse_and_apply(@root, lambda_expr)  # Traverse tree and apply lambda
  end

  # Combines the current BST with another set through union
  def union(other_set)
    other_set.values.each { |v| add(v) }  # Add values from the other set
  end

  # Updates the current BST to contain only elements in the intersection with another set
  def intersection(other_set)
    other_values = other_set.values  # Get values from the other set
    new_values = inorder.select { |v| other_values.include?(v) }  # Find common values
    @root = nil  # Clear current tree
    new_values.each { |v| add(v) }  # Add common values back to the tree
  end

  # Returns a clone of the current BranchingSet
  def clone
    cloned = BranchingSet.new  # Create a new BranchingSet
    inorder.each { |v| cloned.add(v) }  # Add values to the clone
    cloned
  end

  # Retrieves the values stored in the set using inorder traversal
  def values
    inorder  # Return values in sorted order
  end

  # Perform inorder traversal to get sorted values
  def inorder
    traverse_inorder(@root)  # Return values in sorted order
  end

  # Converts the BST to a string representation
  def to_s
    inorder.join(', ')  # Return string format of the set
  end

  # Allows indexed access to elements using inorder traversal
  def [](index)
    inorder[index]  # Fetch the element at the specified index
  end

  private

  # Inserts a node into the BST recursively
  def insert(node, value)
    return TreeNode.new(value) if node.nil?  # Create a new node if at a leaf

    # Insert into left or right subtree based on value comparison
    if value < node.value
      node.left = insert(node.left, value)  # Insert in left subtree
    elsif value > node.value
      node.right = insert(node.right, value)  # Insert in right subtree
    end
    node  # Return the unchanged node pointer
  end

  # Inorder traversal to collect values in sorted order
  def traverse_inorder(node)
    return [] if node.nil?  # Return empty array if no node

    traverse_inorder(node.left) + [node.value] + traverse_inorder(node.right)  # Left, root, right
  end

  # Applies a lambda to each node's value recursively
  def traverse_and_apply(node, lambda_expr)
    return if node.nil?  # Base case for recursion

    node.value = lambda_expr.call(node.value)  # Apply lambda to the current node's value
    traverse_and_apply(node.left, lambda_expr)  # Traverse left subtree
    traverse_and_apply(node.right, lambda_expr)  # Traverse right subtree
  end
end

# TreeNode class to represent each node in the BST
class TreeNode
  attr_accessor :value, :left, :right  # Node value and pointers to left and right children

  # Initializes a TreeNode with a given value
  def initialize(value)
    @value = value
    @left = nil  # Initially, left child is nil
    @right = nil  # Initially, right child is nil
  end
end
