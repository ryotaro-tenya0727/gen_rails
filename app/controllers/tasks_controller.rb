class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit,:update,:destroy]

  def index
    @tasks = current_user.tasks.recent
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      task_logger.debug "ログを出力#{@task.attributes}"
      redirect_to @task,notice: "タスク「#{@task.name}を登録しました」"
    else
      render :new
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}を削除だにょ〜ん"
  end

  private
  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_logger
    @task_logger ||= Logger.new('log/task.log','daily')
  end
end
