require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a email' do
    user.email = 'test'
    expect(user).to_not be_valid
  end

  it 'user with taken email should be invalid' do
    other_user = User.new(email: user.email, password_digest: 'test')
    expect(other_user).to_not be_valid
  end

end
