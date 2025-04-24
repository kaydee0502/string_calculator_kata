class StringCalculator
  DEFAULT_DELIMITER = ','
  DEFAULT_METHOD = 'addition'

  def initialize
    @delimiter = DEFAULT_DELIMITER
    @method = DEFAULT_METHOD
  end

  def perform(input)
    parse_input(input)

    check_for_negative_numbers
    return 0 if @input.empty?
    puts @method
    if @method == 'multiplication'
      multiply
    else
      # default case scenario
      add
    end
  rescue ArgumentError => e
    puts e.message
    0
  end

  private

  def add
    @input.reject { |number| number > 1000 }.inject(:+)
  end

  def multiply
    @input.reject { |number| number > 1000 }.inject(:*)
  end

  def parse_input(input)
    @input = input
    identify_delimiter
    set_method

    process_new_lines
    @input = @input.split(@delimiter).map(&:to_i)
  end

  def process_new_lines
    @input.gsub!("\n", @delimiter)
  end

  def identify_delimiter
    if @input.start_with?("//")
      delimiter_line = @input[0..3]
      @input = @input[4..] # spare new line, reassign @input without delimiter command

      # Strip out the delimiter indentifier
      new_delimiter = delimiter_line.gsub("//", "").strip

      raise "Invalid delimiter" unless valid_delimiter?(new_delimiter)
      set_delimiter new_delimiter
    end
  end

  def check_for_negative_numbers
    negative_numbers = @input.select { |number| number < 0 }
    raise "Negetive numbers not allowed: #{negative_numbers.join(', ')}" unless negative_numbers.empty?
  end

  # Check if the delimiter is a valid integer, if yes then it is not a valid delimiter
  def valid_delimiter?(delimiter)
    !(Integer(delimiter) rescue false)
  end

  def set_method
    @method = 'multiplication' if @delimiter == '*'
  end

  def set_delimiter(delimiter)
    @delimiter = delimiter
  end
end
