# frozen_string_literal: true

require_relative '../concerns/transactionable'

class Redis < Transactionable
  def set(key, value)
    @storages.last[key.to_sym] = value

    { key.to_sym => value }
  end

  def get(key, _value)
    @storages.last[key.to_sym]
  end

  def unset(key, _value)
    @storages.last.delete(key.to_sym)

    nil
  end

  def numequalto(_key, value)
    @storages.last.values.select do |s|
      s == value
    end.count
  end
end
