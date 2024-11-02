# frozen_string_literal: true

require_relative 'invader'
require_relative 'sample_loader'
# Loads radar sample and checks for Invaders patterns
class Radar

  def initialize
    @invader = Invader.new('invader1')
    @radar = SampleLoader.load_sample
  end

  def scan
    @radar.each_with_index do |row, index_row|
      (0..row.length).each do |column|
        check_for_match(index_row, column) if @invader.signature == row[column, @invader.width]
      end
    end
  end

  private

  def detect_invader(row, column)
    invader_detected = true
    # no need to test first row again
    (row + 1..row + @invader.height - 1).each_with_index do |hot_zone_row, index|
      unless @radar[hot_zone_row][column..column + @invader.width - 1] == @invader.pattern.lines[index + 1].chomp
        invader_detected = false
        break
      end
    end
    p invader_detected
  end
end
