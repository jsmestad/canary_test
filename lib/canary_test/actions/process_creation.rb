module CanaryTest
  module Actions
    class ProcessCreation
      def initialize(configuration_obj)
        @cmd = configuration_obj.process_cmd
        @logger = configuration_obj.logger
      end

      def run
        pid = spawn(@cmd)
        Process.detach(pid)
        @logger.log({pid: pid, cmd: @cmd, action: "spawned", message: "Spawned process `#{@cmd}`"})
      end
    end
  end
end
