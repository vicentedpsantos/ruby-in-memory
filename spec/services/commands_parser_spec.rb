# frozen_string_literal: true

require 'pry'
require 'rspec'

require_relative '../../lib/services/redis'
require_relative '../../lib/services/commands_parser'
require_relative '../../lib/commands/get'
require_relative '../../lib/commands/set'
require_relative '../../lib/commands/unset'

RSpec.describe CommandsParser do
  let(:commands_parser) { described_class.new }
  let(:redis) { Redis.new }
  let(:key) { 'vicente' }
  let(:value) { 'santos' }
  let(:key_value) { { key.to_sym => value } }

  describe '#parse_input' do
    subject(:parse_input) { commands_parser.parse_input(input) }

    describe 'GET command' do
      let(:input) { "GET #{key}" }

      before { redis.set('vicente', 'santos') }

      it 'returns a Get command' do
        result = parse_input

        expect(result).to be_an_instance_of(Commands::Get)
        expect(result.run(redis)).to eq(key_value)
      end
    end

    describe 'SET command' do
      let(:input) { "SET #{key} #{value}" }

      it 'returns a Set command' do
        result = parse_input

        expect(result).to be_an_instance_of(Commands::Set)
        expect(result.run(redis)).to eq(key_value)
      end
    end

    describe 'UNSET command' do
      let(:input) { "UNSET #{key}" }

      before { redis.set('vicente', 'santos') }

      it 'returns an Unset command' do
        result = parse_input

        expect(result).to be_an_instance_of(Commands::Unset)
        expect(result.run(redis)).to be_empty
      end
    end

    describe 'NUMEQUALTO command' do
      let(:values_set) { 4 }
      let(:input) { "NUMEQUALTO #{value}" }

      before do
        values_set.times do |i|
          redis.set("key#{i}", value)
        end
      end

      it 'returns a Numequalto command' do
        result = parse_input

        expect(result).to be_an_instance_of(Commands::Numequalto)
        expect(result.run(redis)).to eq(values_set)
      end
    end
  end
end
