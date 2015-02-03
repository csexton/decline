require 'optparse'
require 'ostruct'

module Decline
  class Command
    attr_reader :config, :parser, :subcommands

    def initialize
      @config = OpenStruct.new
      @parser = OptionParser.new
      @subcommands ||= Hash.new
      self.options(@parser) # Callback to the child class
    end

    def add_command(name, command)
      command.add_options do |cli|
        cli.set_program_name "#{parser.program_name} #{name}"
      end

      subcommands[name.to_s] = command

      self
    end

    def add_options(&block)
      block.call(parser)
      self
    end

    def run(argv, parent_config={})
      merge_config(parent_config)
      # I didn't want to use `order!` here because it will mutate argv, but it
      parsed_args = Array(parser.order!(argv))
      call_command(parsed_args)
    end

    protected

    def options(cli)
      #noop
    end

    # Default call method. This should be overridden.
    def call(*args)
      puts parser.help
      exit 1
    end

    private

    def merge_config(other)
      # Ugly way to merge openstructs and/or hashes
      @config = OpenStruct.new other.to_h.merge(config.to_h)
    end

    def has_subcommand?(name)
      subcommands.has_key?(name)
    end

    def call_subcommand(name, *argv)
      cmd = subcommands[name]
      cmd.run(argv, config)
    end

    def call_command(argv)
      if has_subcommand? argv.first
        call_subcommand(*argv)
      else
        call(argv) # Callback to child class
      end
    end
  end
end
