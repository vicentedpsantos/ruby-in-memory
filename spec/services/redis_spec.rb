# frozen_string_literal: true

require_relative '../../lib/services/redis'

require 'rspec'
require 'pry'

RSpec.describe Redis do
  subject(:redis) { described_class.new }

  let(:key) { 'vicente' }
  let(:value) { 'santos' }

  describe '#set' do
    before { redis.set(key, value) }

    it 'sets the correct value' do
      expect(redis.storages.last.length).to eq(1)
      expect(redis.storages.last).to eq({ key.to_sym => value })
    end
  end

  describe '#get' do
    before { redis.set(key, value) }

    it 'gets the correct key-value pair' do
      expect(redis.get(key, nil)).to eq(value)
    end
  end

  describe '#unset' do
    before { redis.set(key, value) }

    it 'unsets the currently set value' do
      redis.unset(key, nil)

      expect(redis.storages.last).to be_empty
    end
  end

  describe '#numequalto' do
    let(:name_set) { 'vicente' }
    let(:values_set) { 4 }

    before do
      values_set.times do |i|
        redis.set("key#{i}", name_set)
      end
    end

    it 'retrieves the correct number of values set' do
      expect(redis.numequalto(nil, 'vicente')).to eq 4
    end
  end
end
