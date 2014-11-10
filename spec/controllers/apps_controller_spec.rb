require 'rails_helper'

describe AppsController do

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new app" do
        expect {
          post :create, app: FactoryGirl.attributes_for(:app)
        }.to change(App, :count).by(1)
      end

      it "responds with: 201 Created" do
        post :create, app: FactoryGirl.attributes_for(:app)
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid attributes" do
      it "does not create a new app" do
        expect {
          post :create, app: FactoryGirl.attributes_for(:invalid_app)
        }.to_not change(App, :count)
      end

      it "responds with: 422 Unprocessable Entity" do
        post :create, app: FactoryGirl.attributes_for(:invalid_app)
        expect(response).to have_http_status(422)
      end

      it "response contains an error message" do
        post :create, app: FactoryGirl.attributes_for(:invalid_app)
        expect(JSON.parse(response.body)['errors']).not_to be_blank
      end
    end
  end

  describe "GET #show" do
    context "for existing app" do
      let(:app) { FactoryGirl.create(:app) }

      it "responds with json" do
        get :show, id: app
        expect(response.header['Content-Type']).to include('application/json')
      end

      it "responds with: 200 OK" do
        get :show, id: app
        expect(response).to have_http_status(200)
      end
    end

    context "for non-existing app" do
      it "responds with: 404 Not Found" do
        get :show, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET #index" do
    before do
      3.times do |i|
        FactoryGirl.create(:app)
      end
    end

    it "responds with json" do
      get :index
      expect(response.header['Content-Type']).to include('application/json')
    end

    it "outputs all the apps" do
      get :index
      expect(JSON.parse(response.body).count).to eq(3)
    end

    it "responds with: 200 OK" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      let(:app) { FactoryGirl.create(:app) }

      it "updates the app with the new values" do
        put :update, id: app, app: FactoryGirl.attributes_for(:app, name: 'Sample App Updated')
        app.reload
        expect(app.name).to eq('Sample App Updated')
      end

      it "responds with: 200 OK" do
        put :update, id: app, app: FactoryGirl.attributes_for(:app, name: 'Sample App Updated')
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid attributes" do
      let(:app) { FactoryGirl.create(:app) }

      it "does not update the app" do
        put :update, id: app, app: FactoryGirl.attributes_for(:app, name: nil)
        name = app.name
        app.reload
        expect(app.name).to eq(name)
      end

      it "responds with: 422 Unprocessable Entity" do
        put :update, id: app, app: FactoryGirl.attributes_for(:app, name: nil)
        expect(response).to have_http_status(422)
      end

      it "response contains an error message" do
        put :update, id: app, app: FactoryGirl.attributes_for(:app, name: nil)
        expect(JSON.parse(response.body)['errors']).not_to be_blank
      end
    end

    context "for non-existing app" do
      it "responds with: 404 Not Found" do
        put :update, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE #destroy" do
    context "for existing app" do
      before do
        @app = FactoryGirl.create(:app)
      end

      it "deletes the requested app" do
        expect { delete :destroy, id: @app }.to change(App, :count).by(-1)
      end

      it "responds with: 204 No Content" do
        delete :destroy, id: @app
        expect(response).to have_http_status(204)
      end
    end

    context "for non-existing app" do
      it "responds with: 404 Not Found" do
        delete :destroy, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

end
