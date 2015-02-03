require 'optparse'
require 'ostruct'

module Decline
  class Command
    attr_reader :config, :default_config
    attr_accessor :default_config

    def add_command(name, command)
      @subcommands ||= Hash.new
      @subcommands[name.to_s] = command
      self
    end

    def parser
      @config ||= OpenStruct.new @default_config
      @parser ||= OptionParser.new
      self.options(@parser) if self.respond_to? :options
      @parser
    end

    def run(argv)
      parsed_args = Array(parser.order(argv))
      call_command(parsed_args) || 0
    end

    def call
      puts parser.help
      return 1
    end


    private

    def has_subcommand?(name)
      @subcommands && @subcommands.has_key?(name)
    end

    def call_subcommand(name, *argv)
      cmd = @subcommands[name]
      cmd.default_config = config
      cmd.run(argv)
    end

    def call_command(argv)
      if has_subcommand? argv.first
        call_subcommand(*argv)
      else
        call(argv)
      end
    end
  end
end
