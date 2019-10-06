RSpec.describe CanaryTest::Actions::ProcessCreation do
  let(:configuration) {
    CanaryTest::Configuration.new
  }

  subject(:action) {
    described_class.new(configuration)
  }

  describe '#run' do
    it 'spawns the provided process and detaches immediately' do
      expect(Process).to receive(:spawn).with(configuration.process_cmd).and_return(1234)
      expect(Process).to receive(:detach).with(1234)
      action.run
    end

    it 'generates a log entry' do
      log_attributes = {pid: 1234, cmd: configuration.process_cmd, action: 'spawned', message: "Spawned process `#{configuration.process_cmd}`"}
      expect(Process).to receive(:spawn).and_return(1234)
      expect(configuration.logger).to receive(:log).with(log_attributes)
      action.run
    end
  end
end
