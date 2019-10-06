module CanaryTest
  module Actions
    class FileCreation
      def initialize(configuration_obj)
        @file = configuration_obj.file_path
        @logger = configuration_obj.logger
      end

      def run
        File.write(@file, "")
        @logger.log({file: @file, action: "created", message: "File created at #{@file}"})
      end

      def log(data = {})
        data.merge!({
          action: self.class.name.split('::').last
        })
      end
    end
  end
end
