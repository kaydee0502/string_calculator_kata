require_relative '../string_calculator'
require_relative '../string_calculator'
RSpec.describe StringCalculator do
  RSpec::Matchers.define :adds_to do |expected|
    match do |string|
      StringCalculator.new(string).add == expected
    end
  end

  describe 'basic additions' do
    it 'returns 0 for empty string' do
      expect("").to adds_to(0)
    end

    it 'returns 3 for "3"' do
      expect("3").to adds_to(3)
    end

    it 'returns 5 for "2,3"' do
      expect("2,3").to adds_to(5)
    end
  end

  describe "#add with given new lines" do
    it 'returns 5 if "1,1\n1,1,0,1" is passed' do
      expect("1,1\n1,1,0,1").to adds_to(5)
    end

    it 'returns 6 if "1,1,1\n1,1\n0,1\n" is passed' do
      expect("1,1,1\n1,1\n0,1\n").to adds_to(6)
    end

    it 'return 56 if "5,20\n26,5" is passed' do
      expect("5,20\n26,5").to adds_to(56)
    end
  end

  describe "#add numbers with custom delimiter" do
    it 'returns 14 if "//;\n1;1;11;0;1" is passed' do
      expect("//;\n1;1;11;0;1").to adds_to(14)
    end

    it 'returns 0 if "//|\n0|0|0\n0" is passed' do
      expect("//|\n0|0|0\n0").to adds_to(0)
    end

    it 'returns 6 if "//sep\n1sep5" is passed' do
      expect("//sep\n1sep5").to adds_to(6)
    end
  end

  describe "#add with negative numbers" do
    it 'raises an exception with a message that contains "-1" if "-1" is provided' do
      expect { StringCalculator.new("-1") }.to raise_error(RuntimeError, /-1/)
    end
  end
end
