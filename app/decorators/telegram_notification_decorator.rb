# frozen_string_literal: true

class TelegramNotificationDecorator < NotificationDecorator
  def initialize(task:)
    super(task:)
  end

  def notify_user
    telegram_client = FakeTelegramClient.new(auth_token: ENV.fetch('FAKE_TELEGRAM_AUTH_TOKEN'))
    telegram_client.send_message(
      chat_id: task.user.telegram_chat_id,
      text: "Task \"#{task.name}\" completed!"
    )
  end
end
