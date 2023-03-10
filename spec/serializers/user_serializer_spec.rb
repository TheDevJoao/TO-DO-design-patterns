# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer do
  subject(:serializer) { described_class.new(user) }

  let(:user) { build_stubbed(:user) }

  describe '#as_json' do
    let(:expected_hash) do
      {
        'id' => user.id,
        'name' => user.name,
        'email' => user.email,
        'phoneNumber' => user.phone_number,
        'telegramChatId' => user.telegram_chat_id,
        'notificationPreferences' => user.notification_preferences
      }
    end

    it 'returns the expected hash' do
      expect(serializer.as_json).to eq(expected_hash)
    end
  end
end
