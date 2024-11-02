# frozen_string_literal: true

# Initiates Invaders and manages patterns
class InvaderLoader
  class InvaderLoaderError < StandardError; end
  KNOWN_INVADERS = {
    invader1: <<~PATTERN,
      --o-----o--
      ---o---o---
      --ooooooo--
      -oo-ooo-oo-
      ooooooooooo
      o-ooooooo-o
      o-o-----o-o
      ---oo-oo---
    PATTERN
    invader2: <<~PATTERN
      ---oo---
      --oooo--
      -oooooo-
      oo-oo-oo
      oooooooo
      --o--o--
      -o-oo-o-
      o-o--o-o
    PATTERN
  }.freeze

  def self.initialize_invaders(invader_type)
    unless KNOWN_INVADERS.key?(invader_type.to_sym) || invader_type == 'all'
      raise InvaderLoaderError, 'Error: Invalid invader type'
    end

    invaders = []
    if invader_type == 'all'
      KNOWN_INVADERS.each do |(type)|
        invaders << Invader.new(type)
      end
    else
      invaders = [Invader.new(invader_type)]
    end
    invaders
  end
end
