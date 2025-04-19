class StringCalculator
  DEFAULT_DELIMITER = ','

  def initialize(input)
    @numbers = input
    @delimiter = DEFAULT_DELIMITER
    parse_input
  end

  def add
    check_for_negative_numbers
    return 0 if @numbers.empty?

    @numbers.inject(:+)
  rescue ArgumentError => e
    puts e.message
    0
  end

  private

  def parse_input
    check_and_apply_custom_delimiter

    process_new_lines
    @numbers = @numbers.split(@delimiter).map(&:to_i)
  end

  def process_new_lines
    @numbers.gsub!("\n", @delimiter)
  end

  def check_and_apply_custom_delimiter
    if @numbers.start_with?("//")
      delimiter_line, *numbers = @numbers.split("\n")
      # Strip out the delimiter indentifier
      delimiter_line = delimiter_line.gsub("//", "").strip

      raise "Invalid delimiter" unless valid_delimiter?(delimiter_line)
      set_delimiter delimiter_line
    end
  end

  def check_for_negative_numbers
    negative_numbers = @numbers.select { |number| number < 0 }
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
