class AppsController < ApplicationController

  def create
    app = App.new(app_params)

    if app.save
      head :created
    else
      render json: {errors: app.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    if requested_app.present?
      render json: requested_app
    else
      head :not_found
    end
  end

  def index
    render json: App.all
  end

  def update
    if requested_app.present?
      if requested_app.update_attributes(app_params)
        head :ok
      else
        render json: {errors: requested_app.errors.full_messages}, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    if requested_app.present?
      if requested_app.destroy
        head :no_content
      else
        render json: {errors: requested_app.errors.full_messages}, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

private
  def requested_app
    @requested_app ||= App.find_by_id(params[:id])
  end

  def app_params
    params.require(:app).permit(:name, :profile, :project_id)
  end
end
