RSpec.describe CanaryTest::Actions::FileDeletion do
  let(:configuration) {
    CanaryTest::Configuration.new
  }

  subject(:action) {
    described_class.new(configuration)
  }

  describe '#run' do
    it 'removes the specified file' do
      expect(FileUtils).to receive(:rm).with(configuration.file_path)
      action.run
    end

    it 'generates a log entry' do
      log_attributes = {file: configuration.file_path, action: 'deleted', message: "File deleted at #{configuration.file_path}"}
      expect(FileUtils).to receive(:rm)
      expect(configuration.logger).to receive(:log).with(log_attributes)
      action.run
    end
  end
end
