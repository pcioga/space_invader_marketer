# frozen_string_literal: true

require_relative 'invader'
require_relative 'sample_loader'
require_relative 'invader_loader'
# Loads radar sample and checks for Invaders patterns
class Radar
  class RadarError < StandardError; end
  
  def initialize(file, invader_type)
    @invader_type = invader_type
    @invaders = InvaderLoader.initialize_invaders
    @radar = SampleLoader.load_sample(file)
  end

  def scan
    @radar.each_with_index do |row, row_index|
      @invaders.each do |invader|
        # skip if pattern is out of bounds
        next if row_index + invader.height > @radar.count

        start_column = 0
        while (match_column = row.index(invader.signature, start_column))
          detect_invader(row_index, match_column, invader)
          start_column = match_column + 1
        end
      end
    end
    puts "\nFindings:"
    @invaders.each do |invader|
      puts "\n"
      puts invader.findings
    end
  end

  private

  def detect_invader(row, column, invader)
    invader_confirmed = true

    # no need to test first row again
    (row + 1..row + invader.height - 1).each_with_index do |hot_zone_row, index|
      unless @radar[hot_zone_row][column..column + invader.width - 1] == invader.pattern.lines[index + 1].chomp
        invader.false_positives += 1
        invader.false_locations << [row, column]
        invader_confirmed = false
        break
      end
    end
    if invader_confirmed
      invader.confirmed += 1
      invader.confirmed_locations << [row, column]
    end
  end
end
