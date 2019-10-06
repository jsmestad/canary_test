RSpec.describe CanaryTest::Actions::HttpRequest do
  let(:configuration) {
    CanaryTest::Configuration.new
  }

  subject(:action) {
    described_class.new(configuration)
  }

  describe '#run' do
    it 'removes connects to the specified host and port' do
      expect(Socket).to receive(:tcp).with(configuration.http_host, configuration.http_port).and_call_original
      action.run
    end

    it 'generates a log entry' do
      log_attributes = {
        bytes_recv: 1287,
        bytes_sent: 43,
        dest_address: configuration.http_host,
        dest_port: configuration.http_port
      }

      expect(Socket).to receive(:tcp).and_call_original
      expect(configuration.logger).to receive(:log).with(hash_including(log_attributes))
      action.run
    end
  end
end
