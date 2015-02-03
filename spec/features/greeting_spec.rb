RSpec.describe "`greet` example" do
  include ExternalExecutable

  before do
    exec_describe_as_command
  end

  describe "examples/greet --bang yay" do
    it "returns success code" do
      expect(exit_status.success?).to eq true
    end

    it "prints 'yay!'" do
      expect(stdout).to eq "yay!"
    end
  end

  describe "examples/greet --bang yell yay" do
    it "returns success code" do
      expect(exit_status.success?).to eq true
    end

    it "prints 'yay!'" do
      expect(stdout).to eq "YAY!"
    end
  end

end
