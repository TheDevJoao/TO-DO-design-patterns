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
    result = TaskCreator.call(user:, status: :pending, name: create_task_params[:name])

    if result.failure?
      render(status: :unprocessable_entity, json: ErrorSerializer.new(result.data[:errors]).as_json)
    else
      render(status: :created, json: TaskSerializer.new(result.data[:task], user).as_json)
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
