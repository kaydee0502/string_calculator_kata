class StringCalculator
  DEFAULT_DELIMITER = ','

  def initialize(input)
    @input = input
    @delimiter = DEFAULT_DELIMITER
    @numbers = parse_numbers
  end

  def add
    return 0 if @input.empty?

    @numbers.inject(:+)
  rescue ArgumentError => e
    puts e.message
    0
  end

  def parse_numbers
    check_and_apply_custom_delimiter

    cleansed_input = process_new_lines
    cleansed_input = cleansed_input.split(@delimiter).map(&:to_i)
    check_for_negative_numbers(cleansed_input)

    cleansed_input
  end

  def process_new_lines
    @input.gsub("\n", @delimiter)
  end

  def check_and_apply_custom_delimiter
    if @input.start_with?("//")
      delimiter_line, *numbers = @input.split("\n")
      # Strip out the delimiter indentifier
      delimiter_line = delimiter_line.gsub("//", "").strip

      raise "Invalid delimiter" unless valid_delimiter?(delimiter_line)
      set_delimiter delimiter_line
    end
  end

  def check_for_negative_numbers(numbers)
    negative_numbers = numbers.select { |number| number < 0 }
    raise "Negetive numbers not allowed: #{negative_numbers.join(', ')}" unless negative_numbers.empty?
  end

  # Check if the delimiter is a valid integer, if yes then it is no t a valid delimiter
  def valid_delimiter?(delimiter)
    !(Integer(delimiter) rescue false)
  end

  def set_delimiter(delimiter)
    @delimiter = delimiter
  end
end
