# frozen_string_literal: true

class TaskSerializer
  attr_reader :task, :user

  def initialize(task, user)
    @task = task
    @user = user
  end

  def as_json
    {
      'id' => task.id,
      'userId' => user.id,
      'status' => task.status,
      'name' => task.name,
      'createdAt' => task.created_at,
      'completedAt' => task.completed_at
    }
  end
end
