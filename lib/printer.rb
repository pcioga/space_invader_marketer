# frozen_string_literal: true

# Handles outputs
class Printer
  def self.print_findings(invaders)
    puts "\nFindings:"
    invaders.each do |invader|
      puts "\nType: #{invader.type}"
      puts '-' * 10
      puts "Confirmed: #{invader.confirmed}"
      puts "Confirmed locations: #{invader.confirmed_locations}" if invader.confirmed_locations.any?
      puts "False positives: #{invader.false_positives}"
      puts "False positives locations: #{invader.false_locations}" if invader.false_locations.any?
      puts '-' * 10
    end
  end

  def self.display_invaders
    puts "\nKnown invaders:"
    InvaderLoader::KNOWN_INVADERS.each do |(type, pattern)|
      puts "\n\nType: #{type}"
      puts "\nPattern:"
      puts pattern
    end
  end
end
