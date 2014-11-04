class ProjectsController < ApplicationController

  def create
    project = Project.new(project_params)

    if project.save
      head :created
    else
      render json: {errors: project.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    if requested_project.present?
      render json: requested_project
    else
      head :not_found
    end
  end

  def index
    render json: Project.all
  end

  def update
    if requested_project.present?
      if requested_project.update_attributes(project_params)
        head :ok
      else
        render json: {errors: requested_project.errors.full_messages}, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if requested_project.present?
      if requested_project.destroy
        head :no_content
      else
        render json: {errors: requested_project.errors.full_messages}, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

private
  def requested_project
    @requested_project ||= Project.find_by_id(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
