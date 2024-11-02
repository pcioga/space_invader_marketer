# frozen_string_literal: true

require_relative '../lib/invader'
require_relative '../lib/invader_loader'

RSpec.describe InvaderLoader do
  describe '.initialize_invaders' do
    context 'with valid invader type' do
      it 'creates single invader for specific type' do
        invaders = described_class.initialize_invaders('invader1')
        expect(invaders.count).to eq(1)
        expect(invaders.first).to be_an(Invader)
        expect(invaders.first.type).to eq('invader1')
      end

      it 'creates all invaders when type is "all"' do
        invaders = described_class.initialize_invaders('all')
        expect(invaders.length).to eq(InvaderLoader::KNOWN_INVADERS.count)
      end
    end

    context 'with invalid invader type' do
      it 'raises InvaderLoaderError' do
        expect {
          described_class.initialize_invaders('invalid_type')
        }.to raise_error(InvaderLoader::InvaderLoaderError, 'Error: Invalid invader type')
      end
    end
  end
end
