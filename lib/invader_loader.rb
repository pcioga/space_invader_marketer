# frozen_string_literal: true

# Initiates Invaders and manages patterns
class InvaderLoader
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

  def self.initialize_invaders
    invaders = []
    KNOWN_INVADERS.each do |(type)|
      invaders << Invader.new(type)
    end

    invaders
  end
end
