# frozen_string_literal: true

require 'pry'
require 'rspec'

require_relative '../../lib/concerns/transactionable'

RSpec.describe Transactionable do
  subject(:transactionable) { described_class.new }

  context 'when initialized' do
    it 'has a list of storages' do
      expect(transactionable.storages).to eq([{}])
    end
  end

  context 'when adding new storages' do
    before { transactionable.add_storage({ vicente: 'santos' }) }

    it 'adds new storages' do
      expect(transactionable.storages.length).to eq(2)
      expect(transactionable.storages.last).to eq({ vicente: 'santos' })
    end
  end

  context 'when committing' do
    before do
      transactionable.add_storage(
        {
          vicente: 'santos',
          augusto: 'santos',
          joao: 'batalha'
        }
      )

      transactionable.add_storage(
        {
          vicente: 'pereira',
          augusto: 'santos',
          joao: 'batalha'
        }
      )
    end

    it 'commits the newest storage' do
      expect(transactionable.commit.length).to eq(1)
      expect(transactionable.commit.first).to eq(
        {
          vicente: 'pereira',
          augusto: 'santos',
          joao: 'batalha'
        }
      )
    end
  end

  context 'when rollbacking' do
    context 'when there is no transaction taking place' do
      before { transactionable.rollback }

      it 'maintains the only storage present' do
        expect(transactionable.storages.length).to eq(1)
      end
    end

    context 'when there is a transaction taking place' do
      before do
        transactionable.add_storage(
          {
            vicente: 'pereira',
            augusto: 'santos',
            joao: 'batalha'
          }
        )

        transactionable.rollback
      end

      it 'maintains at least one storage' do
        expect(transactionable.storages.length).to eq(1)
      end
    end
  end
end
