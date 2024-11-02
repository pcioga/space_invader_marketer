# frozen_string_literal: true

require_relative '../lib/invader'
require_relative '../lib/printer'

RSpec.describe Printer do

  def capture_stdout
    old_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = old_stdout
  end

  describe '.print_findings' do
    let(:invader) do
      instance_double('Invader',
        type: 'invader1',
        confirmed: 1,
        confirmed_locations: [[0, 0]],
        false_positives: 1,
        false_locations: [[1, 1]])
    end

    it 'prints invader findings correctly' do
      output = capture_stdout { described_class.print_findings([invader]) }

      expect(output).to include('Findings:')
      expect(output).to include('Type: invader1')
      expect(output).to include('Confirmed: 1')
      expect(output).to include('Confirmed locations: [[0, 0]]')
      expect(output).to include('False positives: 1')
      expect(output).to include('False positives locations: [[1, 1]]')
    end
  end

  describe '.display_invaders' do
    before do
      stub_const('InvaderLoader::KNOWN_INVADERS', { invader1: "--o--\n--o--" })
    end

    it 'displays known invader patterns' do
      output = capture_stdout { described_class.display_invaders }

      expect(output).to include('Known invaders:')
      expect(output).to include('Type: invader1')
      expect(output).to include('Pattern:')
      expect(output).to include('--o--')
    end
  end
end
