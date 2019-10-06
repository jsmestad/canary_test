module CanaryTest
  class Configuration
    attr_accessor :actions,
                  :file_path,
                  :http_data,
                  :http_host,
                  :http_port,
                  :log_file,
                  :process_cmd

    def initialize(overrides={})
      self.actions = %w(file_creation file_deletion file_modification http_request process_creation)
      self.file_path = File.join(Dir.pwd, "generated_file.tmp")
      self.http_data = "GET / HTTP/1.0\r\nHost: www.ruby-lang.org\r\n\r\n"
      self.http_host = "www.ruby-lang.org"
      self.http_port = 80
      self.process_cmd = "echo \'hello world\'"
    end

    def set!(options={})
      (options || {}).each do |opt, value|
        self.public_send(:"#{opt}=", value)
      end
    end

    def actions=(actions)
      @actions = [actions].flatten
    end

    def file_path=(file_path)
      @file_path = file_path if directory_exists?(file_path)
    end

    def http_port=(port)
      @http_port = port.to_i
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def log_file=(file)
      @logger = Logger.new(file)
    end

    private

    def directory_exists?(file_path)
      Dir.exist?(File.dirname(file_path))
    end
  end

end
