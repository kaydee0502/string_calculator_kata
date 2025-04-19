class StringCalculator
  DEFAULT_DELIMITER = ','

  def initialize(input)
    @input = input
    @delimiter = DEFAULT_DELIMITER
    parse_input
  end

  def add
    check_for_negative_numbers
    return 0 if @input.empty?

    @input.inject(:+)
  rescue ArgumentError => e
    puts e.message
    0
  end

  private

  def parse_input
    check_and_apply_custom_delimiter

    process_new_lines
    @input = @input.split(@delimiter).map(&:to_i)
  end

  def process_new_lines
    @input.gsub!("\n", @delimiter)
  end

  def check_and_apply_custom_delimiter
    if @input.start_with?("//")
      delimiter_line, *numbers = @input.split("\n")
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

  def set_delimiter(delimiter)
    @delimiter = delimiter
  end
end
