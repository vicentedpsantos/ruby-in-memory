# frozen_string_literal: true

require 'rspec'

require_relative '../../lib/commands/base_command'

RSpec.describe Commands::BaseCommand do
  subject(:base_command) { described_class.new(key, value) }

  let(:key) { 'vicente' }
  let(:value) { 'santos' }
  let(:redis_client) { Redis.new }

  describe '#run' do
    before do
      allow(base_command).
        to receive(:command).
        and_return('get')

      allow(redis_client).
        to receive(:get).
        once.
        and_return(:ok)
    end

    it 'touches the client' do
      base_command.run(redis_client)

      expect(redis_client).
        to have_received(:get).
        with(key, value).
        once
    end
  end
end
