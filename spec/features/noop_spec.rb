RSpec.describe "`noop` example" do
  include ExternalExecutable

  before do
    exec_describe_as_command
  end

  ["examples/noop -h", "examples/noop --help"].each do |cmd|
    describe cmd do
      it "returns success code" do
        expect(exit_status.success?).to eq true
      end

      it "prints usage" do
        expect(stdout).to eq "Usage: noop [options]"
      end
    end
  end

  describe "examples/noop" do
    it "returns failure code" do
      expect(exit_status.success?).to eq false
    end

    it "prints usage" do
      expect(stdout).to eq "Usage: noop [options]"
    end
  end

  describe "examples/noop --bad-wolf" do
    it "returns failure code" do
      expect(exit_status.success?).to eq false
    end

    it "prints error" do
      expect(stderr).to include "invalid option"
    end
  end

end
