# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_name     (name)
#  index_projects_on_user_id  (user_id)
#

require "rails_helper"

RSpec.describe Project, type: :model do
  describe "associations" do
    it "belongs to user" do
      user = create(:user)
      project = create(:project, user:)

      expect(project.user).to eq(user)
    end

    it "has many tasks with dependent destroy" do
      reflection = described_class.reflect_on_association(:tasks)

      expect(reflection.macro).to eq(:has_many)
      expect(reflection.options[:dependent]).to eq(:destroy)
    end
  end

  describe "validations" do
    it "is valid with required attributes" do
      expect(build(:project)).to be_valid
    end

    it "is invalid without name" do
      project = build(:project, name: nil)

      expect(project).not_to be_valid
      expect(project.errors[:name]).to be_present
    end
  end
end

