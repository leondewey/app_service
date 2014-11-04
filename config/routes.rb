Rails.application.routes.draw do
  scope :api do
    scope :app do
      scope :master do

        resources :projects, only: [:create, :update, :destroy, :index, :show], defaults: { format: :json }
        resources :people, only: [:create, :update, :destroy, :index, :show], defaults: { format: :json }

      end
    end
  end
end
