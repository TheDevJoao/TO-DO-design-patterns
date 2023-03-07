# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskSerializer do
  let(:user) { create(:user) }
  let(:task) { create(:task) }
  let(:serializer) { described_class.new(task, user) }

  describe '#as_json' do
    it 'returns the expected hash' do
      expected_hash = {
        'id' => task.id,
        'userId' => user.id,
        'status' => task.status,
        'name' => task.name,
        'createdAt' => task.created_at,
        'completedAt' => task.completed_at
      }
      expect(serializer.as_json).to eq(expected_hash)
    end
  end
end
