require_relative '../string_calculator'
require_relative '../string_calculator'
RSpec.describe StringCalculator do
  RSpec::Matchers.define :adds_to do |expected|
    match do |string|
      StringCalculator.new(string).add == expected
    end
  end

  describe '#add' do
    it 'returns 0 for empty string' do
      expect("").to adds_to(0)
    end
  end
end
