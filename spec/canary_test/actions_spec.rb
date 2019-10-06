RSpec.describe CanaryTest::Actions do

  describe '.get_action' do
    it 'aborts the process when the provided name does not match an action class' do
      expect {
        begin
          described_class.get_action('wrong_name')
        rescue SystemExit
          # Continue
        end
      }.to output(/^FAIL - Action `wrong_name` does not match an available action\./).to_stderr
    end

    it 'takes a underscore name and returns the matching class' do
      expect(described_class.get_action('file_creation')).to eql(CanaryTest::Actions::FileCreation)
    end
  end
end
