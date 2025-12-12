require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  it "is included in the helpers" do
    expect(helper.class.ancestors).to include(ApplicationHelper)
  end
end
