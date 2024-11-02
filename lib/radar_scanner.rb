# frozen_string_literal: true

# Scans radar samples and checks for possible matches
class RadarScanner
  def initialize(radar, invaders)
    @radar = radar
    @invaders = invaders
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
  end

  private

  def detect_invader(row, column, invader)
    invader_confirmed = true
    # no need to test first row again
    (row + 1..row + invader.height - 1).each_with_index do |hot_zone_row, index|
      radar_row = @radar[hot_zone_row][column..column + invader.width - 1]
      invader_row = invader.pattern.lines[index + 1].chomp

      unless radar_row.index(invader_row)
        invader_confirmed = false
        invader.update_findings(invader_confirmed, row, column)
        break
      end
    end
    invader.update_findings(invader_confirmed, row, column) if invader_confirmed
  end
end
