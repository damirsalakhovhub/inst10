require "rails_helper"

RSpec.describe ApplicationPolicy do
  subject { described_class.new(user, record) }

  let(:user) { nil }
  let(:record) { double("Record") }

  describe "default permissions" do
    it { expect(subject.index?).to eq(false) }
    it { expect(subject.show?).to eq(false) }
    it { expect(subject.create?).to eq(false) }
    it { expect(subject.new?).to eq(false) }
    it { expect(subject.update?).to eq(false) }
    it { expect(subject.edit?).to eq(false) }
    it { expect(subject.destroy?).to eq(false) }
  end

  describe "Scope" do
    let(:scope) { double("Scope", where: []) }

    subject { described_class::Scope.new(user, scope) }

    it "raises NoMethodError on resolve" do
      expect { subject.resolve }.to raise_error(NoMethodError, /You must define #resolve/)
    end
  end
end
