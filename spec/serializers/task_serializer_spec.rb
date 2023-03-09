# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskSerializer do
  subject(:serializer) { described_class.new(task, user) }

  let(:user) { build_stubbed(:user) }
  let(:task) { build_stubbed(:task) }

  describe '#as_json' do
    let(:expected_hash) do
      {
        'id' => task.id,
        'userId' => user.id,
        'status' => task.status,
        'name' => task.name,
        'createdAt' => task.created_at,
        'completedAt' => task.completed_at
      }
    end

    it 'returns the expected hash' do
      expect(serializer.as_json).to eq(expected_hash)
    end
  end
end
