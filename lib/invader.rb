# frozen_string_literal: true

# Handles Invader findings and pattern logic
class Invader
  attr_reader :signature, :pattern, :width, :height, :type
  attr_accessor :false_positives, :confirmed, :false_locations, :confirmed_locations

  def initialize(invader)
    @type = invader
    process_pattern
    init_stats
  end

  def findings
    {
      @type.to_sym => {
        confirmed: @confirmed,
        confirmed_locations: @confirmed_locations,
        false_positives: @false_positives,
        false_locations: @false_locations
      }
    }
  end

  def update_findings(confirmed, row, column)
    if confirmed
      self.confirmed += 1
      confirmed_locations << [row, column]
    else
      self.false_positives += 1
      false_locations << [row, column]
    end
  end

  private

  def process_pattern
    @pattern = InvaderLoader::KNOWN_INVADERS[@type.to_sym]
    @signature = @pattern.split("\n").first
    @width = @signature.length
    @height = @pattern.lines.count
  end

  def init_stats
    @false_positives = 0
    @confirmed = 0
    @false_locations = []
    @confirmed_locations = []
  end
end
