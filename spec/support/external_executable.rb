require 'open3'

module ExternalExecutable
  attr_reader :stdout, :stderr, :exit_status
  def exec(cmd)
    out, err, @exit_status = Open3.capture3 cmd
    @stdout = out.strip
    @stderr = err.strip
    exit_status.success?
  end

  def exec_describe_as_command
    exec self.class.description
  end
end
