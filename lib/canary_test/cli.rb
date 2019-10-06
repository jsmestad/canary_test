require 'yaml'

module CanaryTest
  class CLI
    attr_reader :configuration

    def self.load_configuration_from_file(config_file)
      YAML.load_file(config_file)
    end

    def initialize(config={})
      @configuration = Configuration.new
      @configuration.set!(config)
    end

    def run!
      @configuration.actions.each do |action_name|
        action_instance = Actions.get_action(action_name).new(@configuration)
        action_instance.run
      end
    end
  end
end
