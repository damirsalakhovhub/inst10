require 'rails_helper'

RSpec.describe "User Authentication", type: :request do
  describe "POST /users/sign_in" do
    let(:user) { create(:user, email: 'test@example.com', password: 'password123') }

    context 'with valid credentials' do
      it 'signs in successfully' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'password123'
          }
        }
        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(home_path)
      end

      it 'signs in with remember me' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'password123',
            remember_me: '1'
          }
        }
        expect(response).to have_http_status(:see_other)
        expect(user.reload.remember_created_at).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'fails to sign in and redirects to landing page' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }
        # Devise with Hotwire returns 422, but we redirect to root_path
        # Check that we're redirected to landing page
        follow_redirect! if response.redirect?
        expect(response).to have_http_status(:success)
        expect(response.body).to include("Sign In")
      end
    end
  end

  describe "POST /users" do
    context 'with valid params' do
      it 'creates a new user' do
        expect {
          post user_registration_path, params: {
            user: {
              email: 'newuser@example.com',
              password: 'password123',
              password_confirmation: 'password123'
            }
          }
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:see_other)
        expect(response).to redirect_to(home_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a user and redirects to landing page' do
        expect {
          post user_registration_path, params: {
            user: {
              email: 'invalid',
              password: 'pass',
              password_confirmation: 'different'
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE /users/sign_out" do
    let(:user) { create(:user) }

    it 'signs out successfully' do
      sign_in user
      delete destroy_user_session_path
      expect(response).to have_http_status(:see_other)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST /users/password" do
    let(:user) { create(:user, email: 'test@example.com') }

    it 'sends password reset instructions' do
      expect {
        post user_password_path, params: {
          user: { email: user.email }
        }
      }.to change { ActionMailer::Base.deliveries.count }.by(1)

      expect(response).to have_http_status(:see_other)
      expect(user.reload.reset_password_token).to be_present
    end

    it 'does not send instructions for non-existent email' do
      expect {
        post user_password_path, params: {
          user: { email: 'nonexistent@example.com' }
        }
      }.not_to change { ActionMailer::Base.deliveries.count }

      # Devise returns 422 for security reasons (to prevent email enumeration)
      expect(response).to have_http_status(:unprocessable_content)
    end
  end

  describe "PUT /users/password" do
    let(:user) { create(:user, email: 'test@example.com', password: 'oldpassword123', password_confirmation: 'oldpassword123') }

    it 'resets password with valid token' do
      raw_token = user.send_reset_password_instructions
      user.reload

      put user_password_path, params: {
        user: {
          reset_password_token: raw_token,
          password: 'newpassword123',
          password_confirmation: 'newpassword123'
        }
      }

      expect(response).to have_http_status(:see_other)
      expect(user.reload.valid_password?('newpassword123')).to be true
    end

    it 'does not reset password with invalid token' do
      put user_password_path, params: {
        user: {
          reset_password_token: 'invalid_token',
          password: 'newpassword123',
          password_confirmation: 'newpassword123'
        }
      }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(user.reload.valid_password?('oldpassword123')).to be true
    end
  end
end
