class TasksController < ApplicationController
  # GET /tasks
  def index
    query = params[:search]
    if (query.present?)
      @tasks = Task.where("title LIKE ? OR detail LIKE ?", "%#{query}%", "%#{query}%")
    else
      @tasks = Task.all
    end
  end

  # GET /tasks/:id
  def show
    @task = Task.find(params[:id])    
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # GET /tasks/:id/edit
  def edit
    @task = Task.find(params[:id])
  end

  # PATCH/PUT /tasks/:id
  def update
    task = Task.find(params[:id])

    if task.update(task_params)
      redirect_to task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/:id
  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to root_url, notice: 'Task was successfully destroyed.'
  end

  private

  def task_params
    params.require(:task).permit(:title, :detail)
  end

end
