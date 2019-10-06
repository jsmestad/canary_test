RSpec.describe CanaryTest::Logger do
  subject(:logger) { described_class.new(STDOUT) }

  it { is_expected.to respond_to(:log) }
end
