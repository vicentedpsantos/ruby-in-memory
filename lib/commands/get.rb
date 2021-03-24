# frozen_string_literal: true

require_relative './base_command'

module Commands
  class Get < BaseCommand
    def command
      'get'
    end
  end
end
