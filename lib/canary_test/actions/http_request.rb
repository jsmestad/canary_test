require 'socket'

module CanaryTest
  module Actions
    class HttpRequest
      def initialize(configuration_obj)
        @host = configuration_obj.http_host
        @port = configuration_obj.http_port
        @data = configuration_obj.http_data
        @logger = configuration_obj.logger
      end

      def run
        request = {}
        Socket.tcp(@host, @port) do |sock|
          sock.print @data
          sock.close_write
          request[:received] = sock.read
          request[:source_address] = sock.local_address.ip_address
          request[:source_port] = sock.local_address.ip_port
        end
        @logger.log({
                      bytes_recv: request[:received].bytesize,
                      bytes_sent: @data.bytesize,
                      dest_address: @host,
                      dest_port: @port,
                      source_address: request[:source_address],
                      source_port: request[:source_port]
                    })
      end
    end
  end
end
