require "rails_helper"

            RSpec.describe "Landing page", type: :system do
              describe "GET /" do
                it "loads page" do
                  visit root_path
                  expect(page.status_code).to eq(200)
                end

                it "displays title" do
                  visit root_path
                  expect(page).to have_content("Bulletproof Product Management")
                end

                it "renders sign in form" do
                  visit root_path
                  expect(page).to have_content("Sign In")
                  expect(page).to have_field("Email")
                  expect(page).to have_field("Password")
                end

                it "renders sign up form" do
                  visit root_path
                  expect(page).to have_content("Sign Up")
                  expect(page).to have_field("Email", count: 2) # Both forms have email field
                  expect(page).to have_field("Password Confirmation") # Only sign up form has this
                end

                it "renders header" do
                  visit root_path
                  expect(page).to have_css("header.layout-header")
                end

                it "renders forgot password link" do
                  visit root_path
                  expect(page).to have_link("Forgot your password?", href: new_user_password_path)
                end
              end
            end

