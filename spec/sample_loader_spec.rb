# frozen_string_literal: true

require_relative '../lib/sample_loader'

RSpec.describe SampleLoader do
  describe '.load_sample' do
    context 'with valid file' do
      before do
        allow(File).to receive(:read).with('./samples/test.txt')
                                     .and_return("--o--\n--o--")
      end

      it 'loads and splits the sample correctly' do
        result = described_class.load_sample('test.txt')
        expect(result).to eq(['--o--', '--o--'])
      end
    end

    context 'with invalid file' do
      it 'raises error when file not found' do
        expect {
          described_class.load_sample('nonexistent.txt')
        }.to raise_error(/Error: File.*not found/)
      end
    end
  end
end
