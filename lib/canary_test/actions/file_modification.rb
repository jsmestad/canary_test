module CanaryTest
  module Actions
    class FileModification
      def initialize(configuration_obj)
        @file = configuration_obj.file_path
        @logger = configuration_obj.logger
      end

      def run
        FileUtils.touch(@file)
        @logger.log({file: @file, action: "modified", message: "File modified at #{@file}"})
      end
    end
  end
end
