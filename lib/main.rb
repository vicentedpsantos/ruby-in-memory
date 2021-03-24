# frozen_string_literal: true

require 'pry'

require_relative './services/redis'
require_relative '../lib/services/commands_parser'

class Main
  def self.take_input(input)
    sanitized = input.chomp.upcase

    case sanitized
    when 'END'
      puts 'Ending program...'
    when 'BEGIN'
      client.beginc
    when 'ROLLBACK'
      client.rollback
    when 'COMMIT'
      client.commit
    else
      command = commands_parser.parse_input(input)
      if command
        result = command.run(client)
        puts result
      end
    end
  end

  def self.client
    @client ||= Redis.new
  end

  def self.commands_parser
    @commands_parser ||= CommandsParser.new
  end
end

client_running = true

while client_running
  puts '==> '
  input = gets

  if ['END', nil].include?(input.chomp)
    client_running = false

    break
  end

  Main.take_input(input)
end
