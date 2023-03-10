# frozen_string_literal: true

RSpec.describe ErrorSerializer do
  subject(:serializer) { described_class.new(errors) }

  let(:errors) { ActiveModel::Errors.new({ status: :unprocessable_entity }) }
  let(:task) { build_stubbed(:task) }

  describe '#as_json' do
    let(:error_hash) do
      {
        'error' => {
          'message' => 'Validation error',
          'details' => task.errors
        }
      }
    end

    it 'returns the error hash' do
      expect(serializer.as_json).to include{error_hash}
    end
  end
end
