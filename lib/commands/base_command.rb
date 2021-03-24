# frozen_string_literal: true

require_relative '../services/redis'

module Commands
  class BaseCommand
    attr_reader :key, :value

    def initialize(key, value = nil)
      @key = key
      @value = value
    end

    def run(client)
      client.public_send(command, key, value)
    end

    def command
      fail NotImplementedError
    end
  end
end
