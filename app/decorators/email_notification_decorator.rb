# frozen_string_literal: true

class EmailNotificationDecorator < NotificationDecorator
  def notify_user
    TaskMailer.with(task:).task_completed_notification.deliver_now
  end
end
