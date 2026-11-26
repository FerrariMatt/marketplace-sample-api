require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    it 'rejects an invalid email format' do
      user.email = 'invalid-email'

      expect(user).not_to be_valid
      expect(user.errors[:email]).to be_present
    end
  end

  describe 'authentication' do
    let(:user) { create(:user, password: 'secret123') }

    it 'accepts the correct password' do
      expect(user.valid_password?('secret123')).to be(true)
    end

    it 'rejects a wrong password' do
      expect(user.valid_password?('wrong-password')).to be(false)
    end
  end
end
