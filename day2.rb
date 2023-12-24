# frozen_string_literal: true

RED_CUBES = 12
GREEN_CUBES = 13
BLUE_CUBES = 14

BAG = {
  "red" => RED_CUBES,
  "green" => GREEN_CUBES,
  "blue" => BLUE_CUBES
}

COLORS = %w[red green blue]

class Game
  attr_reader :id, :revelations

  # A revelation is an array of CubeCounts
  def initialize(id, revelations)
    @id = id
    @revelations = revelations
  end

  def valid?
    revelations.all? { |revelation| revelation.all?(&:valid?) }
  end

  def cube_counts
    revelations.flatten
  end

  def highest_cube_counts
    COLORS.map do |color|
      (cube_counts.select { |cube_count| cube_count.color == color}).max
    end
  end

  def power
    _power(highest_cube_counts)
  end

  def _power(list)
    head = list.first
    tail = list[1..]
    return head if tail.empty?

    head * _power(tail)
  end
end

class CubeCount
  attr_reader :color, :count

  def initialize(color, count)
    @color = color
    @count = count
  end

  def valid?
    BAG[color] >= count
  end

  def <=>(other)
    count <=> other.count
  end

  def *(other)
    other_count = other.is_a?(self.class) ? other.count : other
    count * other_count
  end
end

def game_from_line(line)
  game_id = line[/Game (\d*):/, 1].to_i
  revelation_strings = line[/Game (\d*):(.*)/, 2].split(';')

  revelations = revelation_strings.map do |string|
    cube_set_strings = string.split(',')
    cube_set_strings.map do |string|
      count = string[/ ?(\d*) ?(.*)/, 1].to_i
      color = string[/ ?(\d*) ?(.*)/, 2]
      CubeCount.new(color, count)
    end
  end

  Game.new(game_id, revelations)
end

game_lines = (File.readlines 'day2_puzzle_input.txt').join.split("\n")

games = game_lines.map { |line| game_from_line(line) }
puts "Part 1: #{games.select(&:valid?).sum(&:id)}"

puts "Part 2: #{games.sum(&:power)}"