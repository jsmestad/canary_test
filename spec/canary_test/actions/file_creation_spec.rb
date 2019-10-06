RSpec.describe CanaryTest::Actions::FileCreation do
  let(:configuration) {
    CanaryTest::Configuration.new
  }

  subject(:action) {
    described_class.new(configuration)
  }

  describe '#run' do
    it 'creates the specified file' do
      expect(File).to receive(:write).with(configuration.file_path, "")
      action.run
    end

    it 'generates a log entry' do
      log_attributes = {file: configuration.file_path, action: 'created', message: "File created at #{configuration.file_path}"}
      expect(File).to receive(:write)
      expect(configuration.logger).to receive(:log).with(log_attributes)
      action.run
    end
  end
end
