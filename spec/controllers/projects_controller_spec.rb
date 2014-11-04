require 'rails_helper'

describe ProjectsController do

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new project" do
        expect {
          post :create, project: FactoryGirl.attributes_for(:project)
        }.to change(Project, :count).by(1)
      end

      it "responds with: 201 Created" do
        post :create, project: FactoryGirl.attributes_for(:project)
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid attributes" do
      it "does not create a new project" do
        expect {
          post :create, project: FactoryGirl.attributes_for(:invalid_project)
        }.to_not change(Project, :count)
      end

      it "responds with: 422 Unprocessable Entity" do
        post :create, project: FactoryGirl.attributes_for(:invalid_project)
        expect(response).to have_http_status(422)
      end

      it "response contains an error message" do
        post :create, project: FactoryGirl.attributes_for(:invalid_project)
        expect(JSON.parse(response.body)['errors']).not_to be_blank
      end
    end
  end

  describe "GET #show" do
    context "for existing project" do
      let(:project) { FactoryGirl.create(:project) }

      it "renders json" do
        get :show, id: project
        expect(response.header['Content-Type']).to include('application/json')
      end

      it "responds with: 200 OK" do
        get :show, id: project
        expect(response).to have_http_status(200)
      end
    end

    context "for non-existing project" do
      it "responds with: 404 Not Found" do
        get :show, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET #index" do
    before do
      3.times do |i|
        FactoryGirl.create(:project)
      end
    end

    it "renders json" do
      get :index
      expect(response.header['Content-Type']).to include('application/json')
    end

    it "outputs all the projects" do
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
      let(:project) { FactoryGirl.create(:project) }

      it "updates the project with the new values" do
        put :update, id: project, project: FactoryGirl.attributes_for(:project, name: 'Sample Project Updated')
        project.reload
        expect(project.name).to eq('Sample Project Updated')
      end

      it "responds with: 200 OK" do
        put :update, id: project, project: FactoryGirl.attributes_for(:project, name: 'Sample Project Updated')
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid attributes" do
      let(:project) { FactoryGirl.create(:project) }

      it "does not update the project" do
        put :update, id: project, project: FactoryGirl.attributes_for(:project, name: nil)
        name = project.name
        project.reload
        expect(project.name).to eq(name)
      end

      it "responds with: 422 Unprocessable Entity" do
        put :update, id: project, project: FactoryGirl.attributes_for(:project, name: nil)
        expect(response).to have_http_status(422)
      end

      it "response contains an error message" do
        put :update, id: project, project: FactoryGirl.attributes_for(:project, name: nil)
        expect(JSON.parse(response.body)['errors']).not_to be_blank
      end
    end

    context "for non-existing project" do
      it "responds with: 404 Not Found" do
        put :update, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE #destroy" do
    context "for existing project" do
      before do
        @project = FactoryGirl.create(:project)
      end

      it "deletes the requested project" do
        expect { delete :destroy, id: @project }.to change(Project, :count).by(-1)
      end

      it "responds with: 204 No Content" do
        delete :destroy, id: @project
        expect(response).to have_http_status(204)
      end
    end

    context "for non-existing project" do
      it "responds with: 404 Not Found" do
        delete :destroy, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

end
