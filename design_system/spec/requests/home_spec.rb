require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "displays app name and tagline" do
      get root_path
      expect(response.body).to include(Rails.application.config.app_name)
      expect(response.body).to include("Start building features, not infrastructure")
    end
  end
end
