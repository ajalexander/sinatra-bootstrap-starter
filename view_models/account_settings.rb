class AccountSettingsViewModel
  attr_reader :email_address, :username

  def initialize(user)
    @email_address = user.email_address
    @username = user.username
  end
end