# frozen_string_literal: true

class TaskCreator < ApplicationService
  def initialize(user:, name:, status:)
    @user = user
    @name = name
    @status = status
  end

  def call
    create_task
  end

  private

  attr_reader :user, :name, :status

  def create_task
    task = Task.new(user:, name:, status:)

    if task.invalid?
      FailureResult.new(data: { errors: task.errors.full_messages })
    else
      task.save!
      SuccessResult.new(data: { task: })
    end
  end
end
