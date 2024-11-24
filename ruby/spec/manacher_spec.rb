require_relative '../lib/manacher'

RSpec.describe '#manacher' do
  it 'returns the correct palindrome lengths for a simple string' do
    expect(manacher('abac')).to eq([1, 0, 3, 0, 1, 0, 1])
  end

  it 'returns the correct palindrome lengths for a string with all identical characters' do
    expect(manacher('aaaa')).to eq([1, 2, 3, 4, 3, 2, 1])
  end

  it 'returns the correct palindrome lengths for an empty string' do
    expect(manacher('')).to eq([])
  end

  it 'returns the correct palindrome lengths for a single character string' do
    expect(manacher('a')).to eq([1])
  end

  it 'returns the correct palindrome lengths for a string with no palindromes longer than 1' do
    expect(manacher('abcd')).to eq([1, 0, 1, 0, 1, 0, 1])
  end

  it 'returns the correct palindrome lengths for a string with multiple palindromes' do
    expect(manacher('abacdfgdcaba')).to eq([1, 0, 3, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 3, 0, 1])
  end
end
