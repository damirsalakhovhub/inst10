require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with invalid email format' do
      user = build(:user, :with_invalid_email)
      expect(user).not_to be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with password shorter than 8 characters' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).not_to be_valid
      expect(user.errors[:password]).to be_present
    end

    it 'is valid with password 8 characters or longer' do
      user = build(:user, password: 'password123', password_confirmation: 'password123')
      expect(user).to be_valid
    end

    it 'is not valid with duplicate email' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
    end
  end

  describe 'scopes' do
    let!(:admin_user) { create(:user, :admin) }
    let!(:regular_user) { create(:user) }

    it 'returns only admins with admins scope' do
      expect(User.admins).to contain_exactly(admin_user)
    end

    it 'returns only regular users with regular_users scope' do
      expect(User.regular_users).to contain_exactly(regular_user)
    end
  end

  describe '#admin?' do
    it 'returns true for admin users' do
      user = build(:user, :admin)
      expect(user.admin?).to be true
    end

    it 'returns false for regular users' do
      user = build(:user)
      expect(user.admin?).to be false
    end
  end

  describe 'paper_trail integration' do
    it 'tracks changes' do
      user = create(:user, email: 'old@example.com')
      expect { user.update(email: 'new@example.com') }.to change { user.versions.count }.by(1)
    end
  end
end
