require_relative '../string_calculator'
require_relative '../string_calculator'
RSpec.describe StringCalculator do
  let(:string_calculator) { StringCalculator.new }

  RSpec::Matchers.define :results_to do |expected|
    match do |string|
      string_calculator.perform(string)== expected
    end
  end

  RSpec::Matchers.define :raise_invalid_input do |expected|
    match do |string|
      expect { string_calculator.perform(string) }.to raise_exception(RuntimeError, expected)
    end
  end

  describe 'basic additions' do
    it 'returns 0 for empty string' do
      expect("").to results_to(0)
    end

    it 'returns 3 for "3"' do
      expect("3").to results_to(3)
    end

    it 'returns 5 for "2,3"' do
      expect("2,3").to results_to(5)
    end

    it 'returns 5 for "2,3,1009"' do
      expect("2,3,1009").to results_to(5)
    end
  end

  describe "#add with given new lines" do
    it 'returns 5 if "1,1\n1,1,0,1" is passed' do
      expect("1,1\n1,1,0,1").to results_to(5)
    end

    it 'returns 6 if "1,1,1\n1,1\n0,1\n" is passed' do
      expect("1,1,1\n1,1\n0,1\n").to results_to(6)
    end

    it 'return 56 if "5,20\n26,5" is passed' do
      expect("5,20\n26,5").to results_to(56)
    end
  end

  describe "#add numbers with custom delimiter" do
    it 'returns 14 if "//;\n1;1;11;0;1" is passed' do
      expect("//;\n1;1;11;0;1").to results_to(14)
    end

    it 'returns 0 if "//|\n0|0|0\n0" is passed' do
      expect("//|\n0|0|0\n0").to results_to(0)
    end

    it 'raise an error if "//2\n12522" is passed' do
      expect("//2\n12522").to raise_invalid_input("Invalid delimiter")
    end
  end

  describe "#add with negative numbers" do
    it 'raises an exception with a message that contains "-1" if "-1" is provided' do
      expect("-1").to raise_invalid_input("Negetive numbers not allowed: -1")
    end

    it 'raises an exception with a message that contains "-1, -2" if "-1, -2, 3" is provided' do
      expect("-1, -2, 3").to raise_invalid_input("Negetive numbers not allowed: -1, -2")
    end

    it 'raises an exception with a message that contains "-1, -2" if "//;\n-1;-2;3" is provided' do
      expect("//;\n-1;-2;3").to raise_invalid_input("Negetive numbers not allowed: -1, -2")
    end
  end

  describe "#multiply if the delimiter is *" do
    it "return 6 if '//*\n3*2' is passed" do
      expect("//*\n3*2").to results_to(6)
    end

    it "return 6 if '//*\n3*2*0' is passed" do
      expect("//*\n3*2*0").to results_to(0)
    end
  end
end
