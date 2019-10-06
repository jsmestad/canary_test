module CanaryTest
  module Actions
    class FileDeletion
      def initialize(configuration_obj)
        @file = configuration_obj.file_path
        @logger = configuration_obj.logger
      end

      def run
        FileUtils.rm(@file)
        @logger.log({path: @file, action: "deleted", message: "File deleted at #{@file}"})
      end
    end
  end
end
