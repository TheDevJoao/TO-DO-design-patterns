# frozen_string_literal: true

class TaskCompleter < ApplicationService
  def initialize(task:)
    @task = task
  end

  def call
    task.update!(status: :completed, completed_at: Time.current)

    build_notification_decorator if task.user.notification_preferences['task_completed'].present?
  end

  private

  attr_reader :task

  NOTIFICATION_DECORATORS = {
    'email' => EmailNotificationDecorator,
    'sms' => SmsNotificationDecorator,
    'telegram' => TelegramNotificationDecorator,
    'whatsapp' => WhatsappNotificationDecorator
  }.freeze
  private_constant :NOTIFICATION_DECORATORS

  def build_notification_decorator
    task.user.notification_preferences['task_completed'].each do |client|
      NOTIFICATION_DECORATORS[client].new(task:).notify_user
    end
  end
end
