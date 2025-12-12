require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class.new(current_user, user) }

  let(:user) { create(:user) }

  context 'when user is an admin' do
    let(:current_user) { create(:user, :admin) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:destroy) }

    context 'when trying to delete themselves' do
      let(:user) { current_user }
      it { is_expected.not_to permit_action(:destroy) }
    end
  end

  context 'when user is a regular user' do
    let(:current_user) { create(:user) }

    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:create) }

    context 'viewing their own profile' do
      let(:user) { current_user }
      it { is_expected.to permit_action(:show) }
      it { is_expected.to permit_action(:update) }
    end

    context 'viewing another user profile' do
      let(:user) { create(:user) }
      it { is_expected.not_to permit_action(:show) }
      it { is_expected.not_to permit_action(:update) }
      it { is_expected.not_to permit_action(:destroy) }
    end
  end

  context 'when user is not logged in' do
    let(:current_user) { nil }

    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:show) }
    it { is_expected.not_to permit_action(:create) }
    it { is_expected.not_to permit_action(:update) }
    it { is_expected.not_to permit_action(:destroy) }
  end

  describe 'Scope' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:admin) { create(:user, :admin) }

    context 'when user is an admin' do
      it 'returns all users' do
        scope = UserPolicy::Scope.new(admin, User.all).resolve
        expect(scope).to contain_exactly(user1, user2, admin)
      end
    end

    context 'when user is a regular user' do
      it 'returns only the current user' do
        scope = UserPolicy::Scope.new(user1, User.all).resolve
        expect(scope).to contain_exactly(user1)
      end
    end

    context 'when user is not logged in' do
      it 'returns no users' do
        scope = UserPolicy::Scope.new(nil, User.all).resolve
        expect(scope).to be_empty
      end
    end
  end
end
