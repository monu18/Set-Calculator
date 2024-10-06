# branching_set.rb
require './double_set'

# Subclass for handling BST (BranchingSet)
class BranchingSet < DoubleSet
  attr_accessor :root

  def initialize(values = [])
    @root = nil
    values.each { |v| add(v) }
  end

  def add(value)
    @root = insert(@root, value)
  end

  def apply_lambda(lambda_expr)
    traverse_and_apply(@root, lambda_expr)
  end

  def union(other_set)
    other_set.values.each { |v| add(v) }
  end

  def intersection(other_set)
    other_values = other_set.values  # Get values from the other set
    new_values = inorder.select { |v| other_values.include?(v) }
    @root = nil
    new_values.each { |v| add(v) }
  end

  def clone
    cloned = BranchingSet.new
    inorder.each { |v| cloned.add(v) }
    cloned
  end

  def values
    inorder
  end

  # Tree traversal
  def inorder
    traverse_inorder(@root)
  end

  def to_s
    inorder.join(', ')
  end

  private

  # Insert node into the BST
  def insert(node, value)
    return TreeNode.new(value) if node.nil?

    if value < node.value
      node.left = insert(node.left, value)
    elsif value > node.value
      node.right = insert(node.right, value)
    end
    node
  end

  # Inorder traversal to collect values
  def traverse_inorder(node)
    return [] if node.nil?

    traverse_inorder(node.left) + [node.value] + traverse_inorder(node.right)
  end

  # Apply lambda to each node
  def traverse_and_apply(node, lambda_expr)
    return if node.nil?

    node.value = lambda_expr.call(node.value)
    traverse_and_apply(node.left, lambda_expr)
    traverse_and_apply(node.right, lambda_expr)
  end
end

# TreeNode class to represent each node in the BST
class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end