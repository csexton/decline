require 'optparse'
require 'ostruct'

module Decline
  class Command
    attr_reader :config
    attr_accessor :program_name

    def add_command(name, command)
      @subcommands ||= Hash.new
      @subcommands[name.to_s] = command
      self
    end

    def run(argv, parent_config=nil)
      # I didn't want to use `order!` here because it will mutate argv, but it
      parsed_args = Array(parser(parent_config).order!(argv))
      call_command(parsed_args)
    end

    # Default call method. This should be overridden.
    def call(*args)
      puts parser.help
      exit 1
    end


    private

    def parser(parent_config={})
      @config ||= OpenStruct.new parent_config
      @parser ||= OptionParser.new

      self.options(@parser) if self.respond_to? :options
      @parser
    end

    def has_subcommand?(name)
      @subcommands && @subcommands.has_key?(name)
    end

    def call_subcommand(name, *argv)
      cmd = @subcommands[name]
      cmd.run(argv, config)
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
