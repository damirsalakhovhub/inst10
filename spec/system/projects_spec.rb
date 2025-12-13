require "rails_helper"

RSpec.describe "Projects", type: :system do
  let(:user) { create(:user, password: "password123") }

  def sign_in_via_landing
    visit root_path
    within(".auth-card", text: "Sign In") do
      fill_in "Email", with: user.email
      fill_in "Password", with: "password123"
      check "Remember me" if page.has_unchecked_field?("Remember me")
      click_button "Sign In"
    end
  end

  it "allows creating a project and seeing it in the list" do
    sign_in_via_landing

    click_link "Projects"
    click_link "New Project", match: :first

    fill_in "Name", with: "My Project"
    fill_in "Description", with: "Project description"
    click_button "Create Project"

    expect(page).to have_current_path(project_path(Project.last))
    expect(page).to have_content("My Project")
    expect(page).to have_content("Project description")

    click_link "Projects"
    expect(page).to have_content("My Project")
  end
end

