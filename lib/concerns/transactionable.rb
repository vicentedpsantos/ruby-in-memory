# frozen_string_literal: true

class Transactionable
  attr_accessor :storages

  def initialize
    @storages = [{}]
  end

  def beginc(storage = {})
    storages.push(storage)
  end

  def commit
    reduced = storages.reduce { |h, ha| h.merge(ha) }
    beginc(reduced)
    storages.drop(storages.length - 1)
  end

  def rollback
    storages.pop unless storages.size == 1
  end
end
