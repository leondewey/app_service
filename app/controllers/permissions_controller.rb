class PermissionsController < ApplicationController

  def projects
    person = Person.find_by_id(params[:person_id])
    if person.present? && project_params.present?
      project_params.each do |proj|
        write = proj['write'] || false
        project = Project.find_by_id(proj['project_id'])
        Permission.create(person_id: person.id, project_id: project.id, write: write) if project
      end
      head :ok
    else
      head :not_found
    end
  end

  def people
    project = Project.find_by_id(params[:project_id])
    if project.present? && person_params.present?
      person_params.each do |pers|
        write = pers['write'] || false
        person = Person.find_by_id(pers['person_id'])
        Permission.create(project_id: project.id, person_id: person.id, write: write) if person
      end
      head :ok
    else
      head :not_found
    end
  end

private
  def project_params
    params.permit(projects: [:project_id, :write])[:projects]
  end

  def person_params
    params.permit(people: [:person_id, :write])[:people]
  end
end
