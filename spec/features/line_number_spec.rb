RSpec.describe "`line-number` example" do
  include ExternalExecutable

  before do
    exec_describe_as_command
  end

  context "Passing file name in to be read via ARGF" do
    describe "examples/line-numbers spec/fixtures/line-number-fixture" do
      it "returns success code" do
        expect(exit_status.success?).to eq true
      end

      it "prints a 10 on the 10th line" do
        expect(stdout.lines[9]).to eq "10   ten"
      end
    end

    describe "examples/line-numbers --hex spec/fixtures/line-number-fixture" do
      it "returns success code" do
        expect(exit_status.success?).to eq true
      end

      it "prints a 10 on the 10th line" do
        expect(stdout.lines[9]).to eq "A    ten"
      end
    end
  end

  context "Piping output to the command to be read via ARGF" do
    describe "cat spec/fixtures/line-number-fixture | examples/line-numbers" do
      it "returns success code" do
        expect(exit_status.success?).to eq true
      end

      it "prints a 10 on the 10th line" do
        expect(stdout.lines[9]).to eq "10   ten"
      end
    end

    describe "cat spec/fixtures/line-number-fixture | examples/line-numbers --hex " do
      it "returns success code" do
        expect(exit_status.success?).to eq true
      end

      it "prints a 10 on the 10th line" do
        expect(stdout.lines[9]).to eq "A    ten"
      end
    end
  end
end
