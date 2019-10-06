RSpec.describe CanaryTest::Configuration do

  subject(:obj) { described_class.new }

  describe 'default values' do
    it 'runs all available actions' do
      expect(obj.actions).to include(*%w(file_creation file_deletion file_modification http_request process_creation))
    end

    it 'generates a file in the current directory' do
      expect(obj.file_path).to eql(Dir.pwd + '/generated_file.tmp')
    end

    it 'sets http settings for www.ruby-lang.org' do
      expect(obj.http_host).to eql('www.ruby-lang.org')
      expect(obj.http_port).to eql(80)
      expect(obj.http_data).to_not be_nil
    end

    it 'sets a simple echo command as the process command' do
      expect(obj.process_cmd).to eql("echo \'hello world\'")
    end

    it 'sets up a logger to STDOUT' do
      logger_stub = Logger.new(STDOUT)
      expect(CanaryTest::Logger).to receive(:new).with(STDOUT).and_return(logger_stub)

      expect(obj.logger).to eql(logger_stub)
    end
  end

  describe '#set!' do
    it 'performs mass assignment on the configuration' do
      expect {
        obj.set!({http_port: 443, http_host: 'www.justinsmestad.com'})
      }.to change(obj, :http_port).to(443)
    end
  end

  describe '#actions= override' do
    it 'accepts a single value' do
      expect {
        obj.actions = 'file_deletion'
      }.to change(obj, :actions).to(['file_deletion'])
    end

    it 'accepts an array of values' do
      expect {
        obj.actions = [ 'file_creation', 'file_deletion' ]
      }.to change(obj, :actions).to(['file_creation', 'file_deletion'])
    end
  end

  describe '#http_port= override' do
    it 'converts a string to an integer' do
      expect {
        obj.http_port = '8080'
      }.to change(obj, :http_port).to(8080)
    end
  end

  describe '#logger= override' do
    it 'creates a new logger at the specified location' do
      new_logger_file = './new-logger-location.log'
      expect(CanaryTest::Logger).to receive(:new).with(new_logger_file)
      obj.log_file = new_logger_file
    end
  end

end
