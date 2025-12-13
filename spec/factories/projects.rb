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

FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}" }
    description { "Project description" }
    association :user
  end
end

