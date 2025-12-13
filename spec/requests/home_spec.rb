require "rails_helper"

RSpec.describe "Home", type: :request do
  describe "GET /" do
    it "returns http success" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "displays landing page content" do
      get root_path
      expect(response.body).to include("Bulletproof Product Management")
      expect(response.body).to include("Sign In")
      expect(response.body).to include("Sign Up")
    end
  end
end
