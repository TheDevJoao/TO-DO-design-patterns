# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    tasks = user.tasks

    render(json: tasks.map { |task| TaskSerializer.new(task, user).as_json })
  end

  def show
    task = user.tasks.find(params[:id])

    render(json: TaskSerializer.new(task, user).as_json)
  end

  def create
    task = user.tasks.new(create_task_params.merge(status: :pending))

    if task.save
      render(status: :created, json: TaskSerializer.new(task, user).as_json)
    else
      render(status: :unprocessable_entity, json: ErrorSerializer.new(task.errors.full_messages).as_json)
    end
  end

  def complete
    task = user.tasks.find(params[:id])

    TaskCompleter.call(task:)

    render(json: TaskSerializer.new(task, user).as_json)
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def create_task_params
    params.require(:task).permit(:name)
  end
end
