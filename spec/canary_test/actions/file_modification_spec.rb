RSpec.describe CanaryTest::Actions::FileModification do
  let(:configuration) {
    CanaryTest::Configuration.new
  }

  subject(:action) {
    described_class.new(configuration)
  }

  describe '#run' do
    it 'removes the specified file' do
      expect(FileUtils).to receive(:touch).with(configuration.file_path)
      action.run
    end

    it 'generates a log entry' do
      log_attributes = {file: configuration.file_path, action: 'modified', message: "File modified at #{configuration.file_path}"}
      expect(FileUtils).to receive(:touch)
      expect(configuration.logger).to receive(:log).with(log_attributes)
      action.run
    end
  end
end
