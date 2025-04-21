class TasksController < ApplicationController
  def index
    # @q = Task.ransack(params[:q])
    # @tasks = @q.result(distinct: true)
    @tasks = Task.where(status: "In Progress")
    @completed = Task.where(status: "Completed")
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      Turbo::StreamsChannel.broadcast_append_to "tasks", target: "tasks", html: render_to_string(partial: "task", locals: { task: @task })

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to tasks_path, notice: "Task was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)
    redirect_to root_path
  end

  def toggle_status
    @task = Task.find(params[:id])
    @task.update(status: params[:status])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tasks_path, notice: 'Task updated.' }
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, :due)
  end
end
