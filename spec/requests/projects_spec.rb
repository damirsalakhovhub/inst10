require "rails_helper"

RSpec.describe "Projects", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET /projects" do
    it "lists only current user's projects" do
      create(:project, user:, name: "My Project")
      create(:project, user: other_user, name: "Other Project")

      sign_in user
      get projects_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("My Project")
      expect(response.body).not_to include("Other Project")
    end
  end

  describe "POST /projects" do
    it "creates project for current user" do
      sign_in user

      expect do
        post projects_path, params: { project: { name: "New Project", description: "Desc" } }
      end.to change(Project, :count).by(1)

      project = Project.last
      expect(project.user).to eq(user)
      expect(response).to redirect_to(project_path(project))
    end
  end

  describe "PATCH /projects/:id" do
    it "updates project when owner" do
      project = create(:project, user:, name: "Old")
      sign_in user

      patch project_path(project), params: { project: { name: "Updated" } }

      expect(response).to redirect_to(project_path(project))
      expect(project.reload.name).to eq("Updated")
    end

    it "forbids update for non-owner" do
      project = create(:project, user: other_user, name: "Other")
      sign_in user

      patch project_path(project), params: { project: { name: "Hack" } }

      expect(response).to have_http_status(:redirect).or have_http_status(:forbidden)
      expect(project.reload.name).to eq("Other")
    end
  end
end

