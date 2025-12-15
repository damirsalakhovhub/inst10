class Current < ActiveSupport::CurrentAttributes
  attribute :user, :session

  def user=(user)
    super(user)
    # Can add additional logic here if needed
  end
end
