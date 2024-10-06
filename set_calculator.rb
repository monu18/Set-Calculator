require './double_set'
require './branching_set'
require './arrayed_set'
class SetCalculator
  def initialize
    @calc = DoubleSet.new
  end
  # Start the set calculator loop
  def run
    loop do
      print "> "
      input = gets.chomp.split(' ', 2)  # Split command and arguments
      command = input[0]
      args = input[1]

      case command
      when 'X'
        values = parse_values(args)
        @calc.set_x(values, :tree)
        puts "Set X (BST): #{@calc.instance_variable_get(:@set_x)}"
      when 'Y'
        values = parse_values(args)
        @calc.set_y(values)
        puts "Set Y (Array): #{@calc.instance_variable_get(:@set_y)}"
      when 'm'
        # Trim quotes if the lambda expression is passed as a string with quotes
        args = args.strip  # Remove extra spaces
        if args.start_with?('"') && args.end_with?('"')
          args = args[1...-1]  # Remove the first and last quotes
        end
        lambda_expr = eval(args)  # Ensure that args is evaluated to a valid lambda expression
        if lambda_expr.is_a?(Proc)
          @calc.apply_lambda(lambda_expr)
          puts "Set X after applying lambda: #{@calc.instance_variable_get(:@set_x)}"
        else
          puts "Invalid lambda expression"
        end
      when 'a'
        @calc.add_to_x(args.to_i)
        puts "Set X after adding #{args.to_i}: #{@calc.instance_variable_get(:@set_x)}"
      when 'u'
        @calc.union
        puts "Set X after union with Y: #{@calc.instance_variable_get(:@set_x)}"
      when 'i'
        @calc.intersection
        puts "Set X after intersection with Y: #{@calc.instance_variable_get(:@set_x)}"
      when 'x'
        @calc.swap
        puts "After swap, Set X: #{@calc.instance_variable_get(:@set_x)}, Set Y: #{@calc.instance_variable_get(:@set_y)}"
      when 'l'
        @calc.list_sets
      when 'c'
        @calc.copy_x_to_y
        puts "Set Y after copying from X: #{@calc.instance_variable_get(:@set_y)}"
      when 'q'
        @calc.quit
      else
        puts "Unknown command"
      end
    end
  end

  private

  # Helper method to parse input values
  def parse_values(args)
    args.split(',').map(&:to_i)
  end
end

calculator = SetCalculator.new
calculator.run