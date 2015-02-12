require_relative '../../../view_models/account_settings'

describe 'AccountSettingsViewModel' do
  describe 'initialize' do
    it 'should copy properties from the model' do
      user = User.new
      user.username = 'test'
      user.email_address = 'test@test.com'

      view_model = AccountSettingsViewModel.new(user)

      expect(view_model.username).to eq('test')
      expect(view_model.email_address).to eq('test@test.com')
    end
  end
end