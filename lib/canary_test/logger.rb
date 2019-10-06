require 'etc'

module CanaryTest
  class Logger
    attr_reader :logger

    def initialize(output)
      @file_logger = ::Logger.new(output)
      @logger = Huyegger::Logger.new(@file_logger).tap do |logger|
        logger.context(
          pid: Process.pid,
          process: $0,
          process_name: 'canary_test',
          uid: Process.uid,
          user: Etc.getpwuid(Process.uid).name
        )
      end

      def log(data)
        @logger.info(data)
      end
    end
  end
end
