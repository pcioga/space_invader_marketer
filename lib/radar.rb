# frozen_string_literal: true

require_relative 'invader'
require_relative 'invader_loader'
require_relative 'printer'
require_relative 'radar_scanner'
require_relative 'sample_loader'

# Main coordinator
class Radar
  def initialize(file, invader_type)
    @invaders = InvaderLoader.initialize_invaders(invader_type)
    @radar = SampleLoader.load_sample(file)
  end

  def scan
    RadarScanner.new(@radar, @invaders).scan
    Printer.print_findings(@invaders)
  end
end
