require 'sequel'

describe 'User' do
  describe 'valid' do
    let :user do
      user = User.new
      user.username = 'smith'
      user.email_address = 'smith@test.com'
      user.password = 'test'
      user
    end

    it 'should be false when username is missing' do
      user.username = nil
      expect(user.valid?).to be(false)
    end

    it 'should be false when username is not unique' do
      user.username = 'jdoe'
      expect(user.valid?).to be(false)
    end
    
    it 'should be false when email_address is missing' do
      user.email_address = nil
      expect(user.valid?).to be(false)
    end
    
    it 'should be false when password is missing' do
      user.password = nil
      expect(user.valid?).to be(false)
    end
  end

  describe 'password' do
    it 'should set the hash to nil when passed nil' do
      user = User.first
      user.password = nil
      expect(user.password_hash).to be_nil
    end

    it 'should set the hash to nil when passed an empty string' do
      user = User.first
      user.password = ''
      expect(user.password_hash).to be_nil
    end
  end

  describe 'authenticate?' do
    it 'should be true when sent the correct password' do
      user = User.first
      expect(user.authenticate?('test')).to be(true)
    end

    it 'should be false when sent the wrong password' do
      user = User.first
      expect(user.authenticate?('invalid')).to be(false)
    end
  end

  describe 'find_by_username' do
    it 'should return the user when a match is found' do
      user = User.find_by_username('jdoe')
      expect(user).to be
      expect(user.username).to eq('jdoe')
    end

    it 'should return nil when no matches found' do
      expect(User.find_by_username('invalid')).to be_nil
    end
  end
end