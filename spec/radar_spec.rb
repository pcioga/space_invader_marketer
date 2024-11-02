# frozen_string_literal: true

require_relative '../lib/radar'

RSpec.describe Radar do
  let(:invader_type) { 'invader1' }
  let(:file) { 'sample.txt' }
  let(:sample_data) { ['--o--', '--o--'] }
  let(:invader) { instance_double(Invader) }
  let(:scanner) { instance_double(RadarScanner) }

  before do
    allow(InvaderLoader).to receive(:initialize_invaders).with(invader_type)
                                                         .and_return([invader])
    allow(SampleLoader).to receive(:load_sample).with(file)
                                                .and_return(sample_data)
    allow(RadarScanner).to receive(:new).and_return(scanner)
    allow(scanner).to receive(:scan)
    allow(Printer).to receive(:print_findings)
  end

  describe '#scan' do
    it 'coordinates the scanning process correctly' do
      radar = described_class.new(file, invader_type)
      radar.scan

      expect(InvaderLoader).to have_received(:initialize_invaders).with(invader_type)
      expect(SampleLoader).to have_received(:load_sample).with(file)
      expect(RadarScanner).to have_received(:new).with(sample_data, [invader])
      expect(scanner).to have_received(:scan)
      expect(Printer).to have_received(:print_findings).with([invader])
    end
  end
end
