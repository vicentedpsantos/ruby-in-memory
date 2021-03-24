# frozen_string_literal: true

require_relative './base_command'

module Commands
  class Set < BaseCommand
    def command
      'set'
    end
  end
end
