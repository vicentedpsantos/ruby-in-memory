# frozen_string_literal: true

require_relative './base_command'

module Commands
  class Unset < BaseCommand
    def command
      'unset'
    end
  end
end
