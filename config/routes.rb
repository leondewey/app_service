Rails.application.routes.draw do
  scope :api do
    scope :app do
      scope :master do

        resources :projects, only: [:create, :update, :destroy, :index, :show], defaults: { format: :json } do
          post :people, to: 'permissions#people'
        end

        resources :people, only: [:create, :update, :destroy, :index, :show], defaults: { format: :json } do
          post :projects, to: 'permissions#projects'
        end

      end
    end
  end
end
