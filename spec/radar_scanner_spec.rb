# frozen_string_literal: true

require_relative '../lib/invader'
require_relative '../lib/invader_loader'
require_relative '../lib/sample_loader'
require_relative '../lib/radar_scanner'

RSpec.describe RadarScanner do
  let(:radar_data) { SampleLoader.load_sample('radar_with_invader1.txt') }

  let(:invader) { Invader.new('invader1') }
  let(:scanner) { described_class.new(radar_data, [invader]) }

  describe '#scan' do
    it 'detects exact match correctly' do
      scanner.scan
      expect(invader.confirmed).to eq(1)
      expect(invader.confirmed_locations).to eq([[0, 0]])
      expect(invader.false_positives).to eq(0)
    end

    context 'with partial match' do
      let(:radar_data) do
        [
          '--o-----o--',  # Matches first line
          '---o---o---',  # Matches second line
          '--ooooooo--',  # Matches third line
          'XXXXXXXXXXX',  # Different pattern
          'ooooooooooo',
          'o-ooooooo-o',
          'o-o-----o-o',
          '---oo-oo---'
        ]
      end

      it 'records false positive correctly' do
        scanner.scan
        expect(invader.confirmed).to eq(0)
        expect(invader.false_positives).to eq(1)
        expect(invader.false_locations).to eq([[0, 0]])
      end
    end

    context 'with multiple matches' do
      let(:radar_data) { SampleLoader.load_sample('radar_with_two_invader1.txt') }

      it 'detects all matches correctly' do
        scanner.scan
        expect(invader.confirmed).to eq(2)
        expect(invader.confirmed_locations).to eq([[0, 0], [0, 12]])
        expect(invader.false_positives).to eq(1)
      end
    end

    context 'with multiple invaders' do
      let(:radar_data) { SampleLoader.load_sample('radar_with_two_invaders.txt') }
      let(:invader2) { Invader.new('invader2') }
      let(:scanner_b) { described_class.new(radar_data, [invader, invader2]) }

      it 'detects all matches correctly' do
        scanner_b.scan
        expect(invader.confirmed).to eq(1)
        expect(invader.confirmed_locations).to eq([[24, 89]])
        expect(invader.false_positives).to eq(15)

        expect(invader2.confirmed).to eq(2)
        expect(invader2.confirmed_locations).to eq([[8, 92], [13, 18]])
        expect(invader2.false_positives).to eq(18)
      end
    end
  end
end
