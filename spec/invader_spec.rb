# frozen_string_literal: true

require_relative '../lib/invader'
require_relative '../lib/invader_loader'

RSpec.describe Invader do
  let(:invader) { described_class.new('invader1') }

  describe '#initialize' do
    it 'sets up the invader with correct initial values' do
      expect(invader.type).to eq('invader1')
      expect(invader.false_positives).to eq(0)
      expect(invader.confirmed).to eq(0)
      expect(invader.false_locations).to be_empty
      expect(invader.confirmed_locations).to be_empty
    end

    it 'processes pattern correctly' do
      expect(invader.width).to eq(11)
      expect(invader.height).to eq(8)
      expect(invader.signature).to eq('--o-----o--')
    end
  end

  describe '#findings' do
    before do
      invader.confirmed = 2
      invader.false_positives = 1
      invader.confirmed_locations = [[0, 0], [1, 1]]
      invader.false_locations = [[2, 2]]
    end

    it 'returns correct findings hash' do
      expected_findings = {
        invader1: {
          confirmed: 2,
          confirmed_locations: [[0, 0], [1, 1]],
          false_positives: 1,
          false_locations: [[2, 2]]
        }
      }
      expect(invader.findings).to eq(expected_findings)
    end
  end

  describe '#update_findings' do
    context 'when confirming a match' do
      it 'updates confirmed count and locations' do
        invader.update_findings(true, 1, 2)
        expect(invader.confirmed).to eq(1)
        expect(invader.confirmed_locations).to eq([[1, 2]])
        expect(invader.false_positives).to eq(0)
        expect(invader.false_locations).to be_empty
      end
    end

    context 'when recording false positive' do
      it 'updates false positive count and locations' do
        invader.update_findings(false, 3, 4)
        expect(invader.false_positives).to eq(1)
        expect(invader.false_locations).to eq([[3, 4]])
        expect(invader.confirmed).to eq(0)
        expect(invader.confirmed_locations).to be_empty
      end
    end
  end
end
