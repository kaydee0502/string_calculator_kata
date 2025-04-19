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
    cleansed_input = process_new_lines
    cleansed_input.split(@delimiter).map(&:to_i)
  end

  def process_new_lines
    @input.gsub("\n", @delimiter)
  end
end
