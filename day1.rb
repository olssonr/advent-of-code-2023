# frozen_string_literal: true

LETTER_DIGIT_MAPPING = {
  "oneight" => [1, 8],
  "one" => 1,
  "twone" => [2, 1],
  "two" => 2,
  "threeight" => [3, 8],
  "three" => 3,
  "four" => 4,
  "fiveight" => [5, 8],
  "five" => 5,
  "six" => 6,
  "sevenine" => [7, 9],
  "seven" => 7,
  "eightwo" => [8, 2],
  "eight" => 8,
  "nineight" => [9, 8],
  "nine" => 9
}

def calibration_value(line, with_letters: false)
  numbers = if with_letters
    numbers_with_letters(line)
  else
    numbers(line)
  end

  first_value = numbers.first
  last_value = numbers.last
  "#{first_value}#{last_value}".to_i
end

def numbers(line)
  line.gsub(/\d/).map(&:to_i)
end

def numbers_with_letters(line)
  line.gsub(/oneight|one|twone|two|threeight|three|four|fiveight|five|six|sevenine|seven|eightwo|eight|nineight|nine|\d/).map { |valid_digit| real_digit(valid_digit) }.flatten
end

def real_digit(valid_digit)
  LETTER_DIGIT_MAPPING[valid_digit] || valid_digit.to_i
end

improved_calibration_lines = (File.readlines 'day1_puzzle_input.txt').join.split("\n")

calibration_values = improved_calibration_lines.map { |line| calibration_value(line) }
puts "Part 1: #{calibration_values.sum}"

real_calibration_values = improved_calibration_lines.map { |line| calibration_value(line, with_letters: true) }
puts "Part 2: #{real_calibration_values.sum}"
