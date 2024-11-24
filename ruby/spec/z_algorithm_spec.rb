require_relative "../lib/z_algorithm"

RSpec.describe "Z_Algorithm" do
  it "calculates the Z-array for a simple string" do
    expect(z_algorithm("abacaba")).to eq([7, 0, 1, 0, 3, 0, 1])
  end

  it "calculates the Z-array for a string with repeated characters" do
    expect(z_algorithm("aaaaa")).to eq([5, 4, 3, 2, 1])
  end

  it "calculates the Z-array for a string with no repetitions" do
    expect(z_algorithm("abcdef")).to eq([6, 0, 0, 0, 0, 0])
  end

  it "calculates the Z-array for an empty string" do
    expect(z_algorithm("")).to eq([])
  end

  it "calculates the Z-array for a single character string" do
    expect(z_algorithm("a")).to eq([1])
  end

  it "calculates the Z-array for a string with mixed characters" do
    expect(z_algorithm("abacabadabacaba")).to eq([15, 0, 1, 0, 3, 0, 1, 0, 7, 0, 1, 0, 3, 0, 1])
  end
end
