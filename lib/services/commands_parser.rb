# frozen_string_literal: true

require_relative '../commands/get'
require_relative '../commands/set'
require_relative '../commands/unset'
require_relative '../commands/numequalto'

class CommandsParser
  STRING_SEPARATOR = ' '
  COMMAND_PARTS = {
    command: 0,
    first_arg: 1,
    second_arg: 2
  }.freeze

  def parse_input(string)
    split_input = string.split(STRING_SEPARATOR)

    case split_input[COMMAND_PARTS[:command]].upcase
    when 'GET'
      Commands::Get.new(split_input[COMMAND_PARTS[:first_arg]])
    when 'SET'
      Commands::Set.new(split_input[COMMAND_PARTS[:first_arg]], split_input[COMMAND_PARTS[:second_arg]])
    when 'UNSET'
      Commands::Unset.new(split_input[COMMAND_PARTS[:first_arg]])
    when 'NUMEQUALTO'
      Commands::Numequalto.new(nil, split_input[COMMAND_PARTS[:first_arg]])
    else
      puts 'Invalid command'
    end
  end
end
