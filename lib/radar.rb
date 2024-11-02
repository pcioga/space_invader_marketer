# frozen_string_literal: true

# Loads radar sample and checks for Invaders patterns
require_relative 'invader'

class Radar
  def initialize
    @invader = Invader.new(Invader::KNOWN_INVADERS[:invader1])
  end
end
