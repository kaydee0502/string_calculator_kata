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
    @input.split(@delimiter).map(&:to_i)
  end
end
