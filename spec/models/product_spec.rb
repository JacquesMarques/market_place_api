require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:user) { create(:user) }
  let(:product) { create(:product, user: user) }

  it 'should have a positive price' do
    product.price = -1
    expect(product).to_not be_valid
  end
end
