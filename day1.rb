# frozen_string_literal: true

def calibration_value(line)
  first_value = numbers(line).first
  last_value = numbers(line).last
  "#{first_value}#{last_value}".to_i
end

def numbers(line)
  line.gsub(/\d/).map(&:to_i)
end

improved_calibration_lines = (File.readlines 'day1_puzzle_input.txt').join.split("\n")

calibration_values = improved_calibration_lines.map { |line| calibration_value(line) }

puts "Part 1: #{calibration_values.sum}"
