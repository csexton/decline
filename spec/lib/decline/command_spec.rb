require 'decline'

RSpec.describe Decline::Command do


  it "register a subcommand and call it when running the app" do
    # Set up a test double for our class
    sub = instance_double(Decline::Command)
    expect(sub).to receive(:run)

    # Register that double as a sub-command
    app = Decline::Command.new
    app.add_command(:sub, sub)

    app.run(["sub"])
  end

  it "register a subcommand and call it when running the app" do
    klass = Class.new(Decline::Command) do
      def options(cli)
      end
    end

    sub = instance_double(klass)

    expect(sub).to receive(:options)
    expect(sub).to receive(:run)

    # Register that double as a sub-command
    app = Decline::Command.new
    app.add_command(:sub, sub)

    app.run(["sub"])
  end

end

