class PeopleController < ApplicationController

  def create
    person = Person.new(person_params)

    if person.save
      head :created
    else
      render json: {errors: person.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    if requested_person.present?
      render json: requested_person
    else
      head :not_found
    end
  end

  def index
    render json: Person.all
  end

  def update
    if requested_person.present?
      if requested_person.update_attributes(person_params)
        head :ok
      else
        render json: {errors: requested_person.errors.full_messages}, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if requested_person.present?
      if requested_person.destroy
        head :no_content
      else
        render json: {errors: requested_person.errors.full_messages}, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

private
  def requested_person
    @requested_person ||= Person.find_by_id(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :email)
  end
end
