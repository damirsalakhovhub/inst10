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
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'fails to sign in' do
        post user_session_path, params: {
          user: {
            email: user.email,
            password: 'wrong_password'
          }
        }
        expect(response).to have_http_status(:unprocessable_entity)
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
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a user' do
        expect {
          post user_registration_path, params: {
            user: {
              email: 'invalid',
              password: 'pass',
              password_confirmation: 'different'
            }
          }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
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
end
