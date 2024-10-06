require './double_set'
require './branching_set'
require './arrayed_set'

# Class for managing the Set Calculator operations
class SetCalculator
  # Initializes the SetCalculator with a new DoubleSet instance
  def initialize
    @calc = DoubleSet.new
  end

  # Starts the set calculator loop for user interaction
  def run
    loop do
      print "> "
      input = gets.chomp.split(' ', 2)  # Split command and arguments
      command = input[0]  # First part is the command
      args = input[1]     # Second part is the argument (if any)

      # Process commands based on user input
      case command
      when 'X'
        values = parse_values(args)  # Parse values for set X
        @calc.set_x(values, :tree)  # Create set X as a BST
        puts "Set X (BST): #{@calc.instance_variable_get(:@set_x)}"
      when 'Y'
        values = parse_values(args)  # Parse values for set Y
        @calc.set_y(values)  # Create set Y as an ArrayedSet
        puts "Set Y (Array): #{@calc.instance_variable_get(:@set_y)}"
      when 'm'
        # Trim quotes if the lambda expression is passed as a string with quotes
        args = args.strip  # Remove extra spaces
        if args.start_with?('"') && args.end_with?('"')
          args = args[1...-1]  # Remove the first and last quotes
        end
        lambda_expr = eval(args)  # Evaluate the string to obtain a lambda expression
        if lambda_expr.is_a?(Proc)
          @calc.apply_lambda(lambda_expr)  # Apply the lambda to set X
          puts "Set X after applying lambda: #{@calc.instance_variable_get(:@set_x)}"
        else
          puts "Invalid lambda expression"
        end
      when 'a'
        @calc.add_to_x(args.to_i)  # Add a value to set X
        puts "Set X after adding #{args.to_i}: #{@calc.instance_variable_get(:@set_x)}"
      when 'u'
        @calc.union  # Perform union of sets X and Y
        puts "Set X after union with Y: #{@calc.instance_variable_get(:@set_x)}"
      when 'i'
        @calc.intersection  # Perform intersection of sets X and Y
        puts "Set X after intersection with Y: #{@calc.instance_variable_get(:@set_x)}"
      when 'x'
        @calc.swap  # Swap sets X and Y
        puts "After swap, Set X: #{@calc.instance_variable_get(:@set_x)}, Set Y: #{@calc.instance_variable_get(:@set_y)}"
      when 'l'
        @calc.list_sets  # List the contents of both sets
      when 'c'
        @calc.copy_x_to_y  # Copy the contents of set X to set Y
        puts "Set Y after copying from X: #{@calc.instance_variable_get(:@set_y)}"
      when 'q'
        @calc.quit  # Exit the program
      else
        puts "Unknown command"  # Handle unrecognized commands
      end
    end
  end

  private

  # Helper method to parse input values from the command line
  def parse_values(args)
    args.split(',').map(&:to_i)  # Split the input string by commas and convert to integers
  end
end

# Create an instance of SetCalculator and run the interactive loop
calculator = SetCalculator.new
calculator.run
