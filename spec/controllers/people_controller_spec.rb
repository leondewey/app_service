require 'rails_helper'

describe PeopleController do

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new person" do
        expect {
          post :create, person: FactoryGirl.attributes_for(:person)
        }.to change(Person, :count).by(1)
      end

      it "responds with: 201 Created" do
        post :create, person: FactoryGirl.attributes_for(:person)
        expect(response).to have_http_status(201)
      end
    end

    context "with invalid attributes" do
      it "does not create a new person" do
        expect {
          post :create, person: FactoryGirl.attributes_for(:invalid_person)
        }.to_not change(Person, :count)
      end

      it "responds with: 422 Unprocessable Entity" do
        post :create, person: FactoryGirl.attributes_for(:invalid_person)
        expect(response).to have_http_status(422)
      end

      it "response contains an error message" do
        post :create, person: FactoryGirl.attributes_for(:invalid_person)
        expect(JSON.parse(response.body)['errors']).not_to be_blank
      end
    end
  end

  describe "GET #show" do
    context "for existing person" do
      let(:person) { FactoryGirl.create(:person) }

      it "responds with json" do
        get :show, id: person
        expect(response.header['Content-Type']).to include('application/json')
      end

      it "responds with: 200 OK" do
        get :show, id: person
        expect(response).to have_http_status(200)
      end
    end

    context "for non-existing person" do
      it "responds with: 404 Not Found" do
        get :show, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "GET #index" do
    before do
      3.times do |i|
        FactoryGirl.create(:person)
      end
    end

    it "responds with json" do
      get :index
      expect(response.header['Content-Type']).to include('application/json')
    end

    it "outputs all the people" do
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
      let(:person) { FactoryGirl.create(:person) }

      it "updates the person with the new values" do
        put :update, id: person, person: FactoryGirl.attributes_for(:person, name: 'Roger Updated')
        person.reload
        expect(person.name).to eq('Roger Updated')
      end

      it "responds with: 200 OK" do
        put :update, id: person, person: FactoryGirl.attributes_for(:person, name: 'Roger Updated')
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid attributes" do
      let(:person) { FactoryGirl.create(:person) }

      it "does not update the person" do
        put :update, id: person, person: FactoryGirl.attributes_for(:person, name: nil)
        name = person.name
        person.reload
        expect(person.name).to eq(name)
      end

      it "responds with: 422 Unprocessable Entity" do
        put :update, id: person, person: FactoryGirl.attributes_for(:person, name: nil)
        expect(response).to have_http_status(422)
      end

      it "response contains an error message" do
        put :update, id: person, person: FactoryGirl.attributes_for(:person, name: nil)
        expect(JSON.parse(response.body)['errors']).not_to be_blank
      end
    end

    context "for non-existing person" do
      it "responds with: 404 Not Found" do
        put :update, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "DELETE #destroy" do
    context "for existing person" do
      before do
        @person = FactoryGirl.create(:person)
      end

      it "deletes the requested person" do
        expect { delete :destroy, id: @person }.to change(Person, :count).by(-1)
      end

      it "responds with: 204 No Content" do
        delete :destroy, id: @person
        expect(response).to have_http_status(204)
      end
    end

    context "for non-existing person" do
      it "responds with: 404 Not Found" do
        delete :destroy, id: 0
        expect(response).to have_http_status(404)
      end
    end
  end

end
