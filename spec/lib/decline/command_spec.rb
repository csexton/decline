RSpec.describe Decline::Command do

  it "register a subcommand and call it when running the app" do
    # Set up a test double for our class
    sub = instance_double(Decline::Command)
    allow(sub).to receive(:add_options)
    expect(sub).to receive(:run)

    # Register that double as a sub-command
    app = Decline::Command.new
    app.add_command(:sub, sub)

    app.run(["sub"])
  end

  it "injects the parent name into the program_name" do
    sub = Decline::Command.new
    allow(sub).to receive(:exit)

    app = Decline::Command.new
    app.add_command(:sub, sub)

    expect{app.run(["sub"])}.to output("Usage: rspec sub [options]\n").to_stdout
  end

  it "merges parent config settings" do

    # Create a parent with a `-n` option set
    parent = Class.new(Decline::Command) do
      def options(cli)
        cli.on('-n') do
          config.lucky_number = 13
        end
      end
    end.new

    # Read that config in the child
    child = Class.new(Decline::Command) do
      def call(*args)
        print config.lucky_number
      end
    end.new

    parent.add_command :child, child

    # Verify it is run by reading stdout
    expect{parent.run(%w(-n child))}.to output("13").to_stdout
  end
end

