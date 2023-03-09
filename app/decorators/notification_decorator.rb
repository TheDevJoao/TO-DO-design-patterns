# frozen_string_literal: true

class NotificationDecorator
  def initialize(task:)
    @task = task
  end

  def user
    task&.user
  end

  def name
    task&.name
  end

  def status
    task&.status
  end

  def completed_at
    task&.completed_at
  end

  private

  attr_reader :task
end
