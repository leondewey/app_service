require 'rails_helper'

describe PermissionsController do

  describe "POST #projects" do
    context "for existing person" do
      let(:person) { FactoryGirl.create(:person) }

      context "with valid attributes" do
        let(:projects){
          projects = []
          projects << FactoryGirl.attributes_for(:permission_ro, project_id: FactoryGirl.create(:project).id)
          projects << FactoryGirl.attributes_for(:permission_rw, project_id: FactoryGirl.create(:project).id)
          projects << FactoryGirl.attributes_for(:permission_ro, project_id: FactoryGirl.create(:project).id)
          projects
        }

        it "adds the project permissions to the person" do
          expect{post :projects, person_id: person.id, projects: projects}.to change(person.permissions, :count).by(3)
        end

        it "responds with: 200 OK" do
          post :projects, person_id: person.id, projects: projects
          expect(response).to have_http_status(200)
        end
      end

      context "with invalid attributes" do
        it "does not modify any records" do
          expect{post :projects, person_id: person.id, projects: [{rubbish: 'here'}]}.to_not change(person.permissions, :count)
        end
      end
    end

    context "for non-existing person" do
      it "responds with: 404 Not Found" do
        post :projects, person_id: 0, projects: []
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "POST #people" do
    context "for existing project" do
      let(:project) { FactoryGirl.create(:project) }

      context "with valid attributes" do
        let(:people){
          people = []
          people << FactoryGirl.attributes_for(:permission_ro, person_id: FactoryGirl.create(:person).id)
          people << FactoryGirl.attributes_for(:permission_rw, person_id: FactoryGirl.create(:person).id)
          people << FactoryGirl.attributes_for(:permission_ro, person_id: FactoryGirl.create(:person).id)
          people
        }

        it "adds the person permissions to the project" do
          expect{post :people, project_id: project.id, people: people}.to change(project.permissions, :count).by(3)
        end

        it "responds with: 200 OK" do
          post :people, project_id: project.id, people: people
          expect(response).to have_http_status(200)
        end
      end

      context "with invalid attributes" do
        it "does not modify any records" do
          expect{post :people, project_id: project.id, people: [{rubbish: 'here'}]}.to_not change(project.permissions, :count)
        end
      end
    end

    context "for non-existing project" do
      it "responds with: 404 Not Found" do
        post :people, project_id: 0, people: []
        expect(response).to have_http_status(404)
      end
    end
  end

end
