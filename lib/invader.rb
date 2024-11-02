# frozen_string_literal: true

# Handles Invader patterns and findings logic
class Invader
  attr_reader :signature

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

  def initialize(invader)
    @pattern = KNOWN_INVADERS[invader.to_sym]
    @signature = @pattern.split("\n").first
  end
end
